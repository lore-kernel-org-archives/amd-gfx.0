Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A67BC7EE24
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jun 2023 15:37:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A989910E0DF;
	Tue,  6 Jun 2023 15:37:02 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73F1310E0DF
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jun 2023 15:37:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BmC4TdGL5H4zg6tUedZYwFk2mm4gt3IYoC8mp52sjUIkTQd5JqszhEErKmzG9CC64x4MM8GsaT80bGGGmJKKNGGoPvfKiQY6QykmrCmGJXqRoXVO3a7dI+6ZkzoU2qELL5vrNntZGOuYMW7AtoxOT6B96R0H9tszUR3yXFX3VRM7NsMkuL5klrM1o+YyOqVUEk1gUJhCe9Xt+wV5Qr4hX08MEQItlNnXPI7cxAW9q8O8AfOvZv5J4Gt4QZ24AdTQCuyqoGgywA4+shxjGB5aMg08M7gQ2C4yNRK+Q5Qav7B3gexbbniDjFnAhItE3nlVoiZrHB67/OBw2U6ABy2Lig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KtASoq+s5Ab7sutXcCo2x/TWdoXAh0Z+BuCm+Dj/xAQ=;
 b=jg0Nsk9BtE6dfi1OUnEGQd52g7CWzJsb6r0/Od3/y7LNjwwtLhCAD2JR7XOfx11RjI3vmS5yM120mNsG1er+CTCtJQARvAy5YjkxFkKRaKFunlDL0VuIgdkA1ywHltYPaXtFGpVPXXOdPZTmBSjbY3WRvZW7hTKITnZ01ISz9cFUK5hIMVhTbncTM9Xp9bzHXhLejNVyJI4sQe/n31QuROn/NvnBt6Zd8K/hnX8FcPyYVzu6KgpeOMlJLq4jSGzKs7MLKXljW1FvB8BKfhkjqYv7utqc8txrFuYxObq7Ghi9aXh9xvCYBbHPc0nMl3KE/LjZk00wSoXIHBcjHNEUPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KtASoq+s5Ab7sutXcCo2x/TWdoXAh0Z+BuCm+Dj/xAQ=;
 b=SBjK08t7t2GCgeg7gm52wGnIg4+YbAdInlGq1JyN73JL/S0ZP66BrHImbAqsHYsIbcrPI79/9Fj6Vh+EeR4yoaTynvQ7NO07IRgHw5wYPDosDPvfUSFGI3+Ra6Q33G6aXUwicEd8Ol2UZuBSwqMMBjFpuheT6cBUMlRRw4oWPgo=
Received: from BN1PR14CA0016.namprd14.prod.outlook.com (2603:10b6:408:e3::21)
 by PH8PR12MB6723.namprd12.prod.outlook.com (2603:10b6:510:1ce::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 15:36:56 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e3:cafe::13) by BN1PR14CA0016.outlook.office365.com
 (2603:10b6:408:e3::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Tue, 6 Jun 2023 15:36:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.34 via Frontend Transport; Tue, 6 Jun 2023 15:36:55 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Jun
 2023 10:36:55 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add missing radeon secondary PCI ID
Date: Tue, 6 Jun 2023 11:36:40 -0400
Message-ID: <20230606153640.2966557-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT048:EE_|PH8PR12MB6723:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c778a0c-783d-4db8-74ae-08db66a3dc01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZlfP0jg+4v2EyFDJZYY4S7SL5YQIxHBMg+dHAj5qedkGZ7BzPzIpN51rZPnGBHAip2CfdhH41kkHLVj5zH/oqZ9p7InA21CKRtx8bu35+oR5PpV+v/DWuW22tced0b1MwgklymfPs3E8ZdQQ75TD5jCjWYsH64bME21vr6Hws5FYur20B7cQLb0GrAghGHDEx2xBTzw7Pb/PlrxxzYWHYRDI/MZpe6odcugusXevBvu3ww9i1oafHGAREi7Q8bOfKwSPBjy5DtXZTn5e3fBJa1U7dttkStbBAf7BISxPzJfHK2TRW3f51asxiB3sDHWdII257Gx21vHMLlv0+g86xjqdoRU/WLJg9qb+MAJ6yV4IcRACwR60+hEjVb/S2UY1jCp7lfVXmGVfWhGK9+AKed9/lMEsJ0i+aDgvQh6hgvRnYFqztAPDjrJwArXkJN6Ku82u/P5GUEdY34VmrH5Bx8NtWQEZCsGZuPebsEU8RXQcUZCgrhVuKAyXtDSfXwAEIHaF9jqlaIF7S4xnz9sT/WlwgE7ZVtLDfn2VpzCHzFCiIIrLk48XRXGBcEcQmBGZvmMo4/qVX7uGTZuUYUqdgLmFbClHL7aLTwVU2Xe6eu2Fex4fSLrM092GUDSTDpFOYXmZpv21LH37zuHGCRAFqnfuUB4LAzouKC8IoOWd1rJGLZzY1pQ61qWUYb38NEVpSEeLnVd016ieZvMfOi40ArHAO0Tl/YHhEEuxh2Jh6aUur9nC+HOfXNlvSfU4lIwTIhoEmFs3L2HjrwnLWYd/gA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199021)(40470700004)(36840700001)(46966006)(86362001)(47076005)(426003)(336012)(478600001)(6666004)(54906003)(40480700001)(5660300002)(8936002)(8676002)(82740400003)(316002)(81166007)(70586007)(70206006)(356005)(40460700003)(4326008)(6916009)(41300700001)(36756003)(4744005)(2906002)(7696005)(36860700001)(82310400005)(1076003)(26005)(16526019)(186003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 15:36:55.9373 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c778a0c-783d-4db8-74ae-08db66a3dc01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6723
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
Cc: Alex Deucher <alexander.deucher@amd.com>, michel@daenzer.net
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

0x5b70 is a missing RV370 secondary id.  Add it so
we don't try and probe it with amdgpu.

Cc: michel@daenzer.net
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 7489b2b1a0d0..b8a1e4571cd9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1640,6 +1640,7 @@ static const u16 amdgpu_unsupported_pciidlist[] = {
 	0x5874,
 	0x5940,
 	0x5941,
+	0x5b70,
 	0x5b72,
 	0x5b73,
 	0x5b74,
-- 
2.40.1

