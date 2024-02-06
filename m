Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6E0EC4829C
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Feb 2024 20:22:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 223C8112DEB;
	Tue,  6 Feb 2024 20:22:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1vYtU0Zh";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DAF2112DE9
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Feb 2024 20:22:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gcSary/DKp3l0H/Ek1NPTYrlS24ycwEu9/hlnGHBpcXldjYc7nSi11fh2L7rRnqf+8iNW0kPIpLGrZfwSOuHGiYhiE1IkodT7mKMw7qUWm/jWNZVFqjn7r7J3swosUPwdGyv7giIrIOg8fbyCbmqd2Dpa/SmOmcJnQf8xmhx76LFt6aSTBa/wcfKoc8GoCjTwWDGWncwEP7WwIBZIPEFSfI5fyLoew/PldIh9QnRo7AE/f5pxXyUHz5j/+WB6H+j8cUQsnrqumE9iAoVgEmMwYhSIvNAIBrOKl3C6mnWRb/B+P4Gn6B7g4z6kL2ScSH/voRc2XRkjXvQpjSSs89C7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fk0FBZ7Yyg0vgnndz9RuLFMRUTzonzLeytTEqPQt58g=;
 b=jpuULvged19DH3/kMFAuuT+2TrBd5yOyQcaPHiWJ/s6HDBqVlEujajbeWxB//SH1DzTJ6AvEbFdqe3OfSI95M1cRXw+drMKFmlYy2CiFnUcavsvZ2+m3JXVHVGTA/a+yzXOTa/MiLtcWrOLxsh2mZ4HvFEW39Ps3cnFFWBPvyOuZnnLvdkvmO41eGWvPGGSice5TWAe1QkBftk+rpnXIsoLmg13lVHgbTxdDUD0d6rXk8m9J9UDkEvbGMalLNCS7C53R0cu953g09NdUfWihppZ8zCxKLD4GwQdQA8nu3Ew0k/vQlnwsKghfdPEr6BSOtNPv3WCPyZi4OvFjvhiscw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fk0FBZ7Yyg0vgnndz9RuLFMRUTzonzLeytTEqPQt58g=;
 b=1vYtU0ZhhIdmh9WjxEHJJJ8lxoCk7XIZimr/TJ4xVR8AemS88hIZCIuJZL1MxErsZvScRZuYh4wMlVgRJhm/LwzxS3ct82Ic3k9+M+pZusQi8+tf0hHBl76sHsESLyorJPfVyVHgfp+Pkh7M3UPMITYOqQ5x/Vo8sjTKU8utuOs=
Received: from BL0PR0102CA0040.prod.exchangelabs.com (2603:10b6:208:25::17) by
 MW4PR12MB7336.namprd12.prod.outlook.com (2603:10b6:303:21a::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7270.14; Tue, 6 Feb 2024 20:22:46 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:25:cafe::7e) by BL0PR0102CA0040.outlook.office365.com
 (2603:10b6:208:25::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 20:22:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 6 Feb 2024 20:22:45 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 6 Feb
 2024 14:22:44 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 3/3] drm/amdgpu/discovery: Add ih v7_0 ip block
Date: Tue, 6 Feb 2024 15:22:27 -0500
Message-ID: <20240206202227.1671475-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240206202227.1671475-1-alexander.deucher@amd.com>
References: <20240206202227.1671475-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|MW4PR12MB7336:EE_
X-MS-Office365-Filtering-Correlation-Id: a59074f3-b13e-4e91-7263-08dc27516147
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MjGpzHOdcbCAmTwf82K0Enz0Z3xqbTM6pWlOXriCh2KLQVsrItMLrU8SR9ocKPfyzgzpeQld0ETh34ZjNykm3f6gOCOcQEne8KipSgOPvnu9NroKWLVQJZRBIZcwy8fX1e2Lnf6hHPU02wOFzEQIVTXQfGSx5DS0usLNdNy77vtwYUAMRZMynSR9RhAk/3xpUnXz9VK0zVOP3ueU/pWB3SW7nFORFef2/ERz/fV74k31FstkwhFQmwVHi/ytjSz7Db4+R1idXoDB1JV6nv5/CWqyoLZEXprfeYDxOR6M4qDZ0AvwnXiT3y/3oFCAuNfiDeNEiKawAPfLqSLmc1mBHOtAp3+zPV1EyE1zDZs+DoLh4IRPpmZ1WErn04ck+rCw3TtZhNbTOJZ/2C9E42c1hFkjTzlWnWHUIjXzwjqGBspGw6fnuU8Ps7hSn1hUzjDaRm7I1s5T/uC3yWBjYcfiY+3UfFVOZi9Puy206FVudKV8zWs5e+1IReAYEmOw7sgQNodTS0DPoc/NK2gXr6a+TbeD+Mdxdl7K6QexyEaJDoNBDwPAzt6PvvO+zpRHaAfxt+5VWpu/yzq+t/7Xa0ZTtCb4tvxi87QEbXYzs61pVODg+UGtLbZcbfz8qPHIJklYdLGNn/DuHQf+Ir9K0gk5PsyQDo1G5FkYfG5fSiMXsnBVhMSbNL42eas+qe0HtmgXkCJUqsvqiiZ84wW23tiyr9RvcP3f8yLaGlRY3Tpvz3Lx3Bvf7Xgmy+npxuw1ZeVD4MmUum5EdvP84oQDZITqBg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(82310400011)(1800799012)(186009)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(36756003)(478600001)(86362001)(47076005)(2616005)(82740400003)(83380400001)(26005)(6666004)(336012)(16526019)(356005)(41300700001)(1076003)(70586007)(4326008)(5660300002)(316002)(81166007)(54906003)(426003)(2906002)(70206006)(8936002)(8676002)(7696005)(36860700001)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 20:22:45.7205 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a59074f3-b13e-4e91-7263-08dc27516147
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7336
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Add ih v7_0 ip block.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index e941aeb6f16a..c4370f154e8b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -69,6 +69,7 @@
 #include "navi10_ih.h"
 #include "ih_v6_0.h"
 #include "ih_v6_1.h"
+#include "ih_v7_0.h"
 #include "gfx_v10_0.h"
 #include "gfx_v11_0.h"
 #include "sdma_v5_0.h"
@@ -1768,6 +1769,9 @@ static int amdgpu_discovery_set_ih_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(6, 1, 0):
 		amdgpu_device_ip_block_add(adev, &ih_v6_1_ip_block);
 		break;
+	case IP_VERSION(7, 0, 0):
+		amdgpu_device_ip_block_add(adev, &ih_v7_0_ip_block);
+		break;
 	default:
 		dev_err(adev->dev,
 			"Failed to add ih ip block(OSSSYS_HWIP:0x%x)\n",
-- 
2.42.0

