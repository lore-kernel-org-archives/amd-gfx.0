Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37579ECAAA1
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Sep 2022 21:40:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4515810E00F;
	Fri,  9 Sep 2022 21:40:24 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE67210E00F
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Sep 2022 21:40:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dkFTkKIJ1kIsSPrfm7jFoy25Fzk6rRrzucFbtB4zL/2iogsC10NW19nFzRCPAwdYQTED2A9lJhQuhzOfFA0nBoKXmF/HfXffn7RxWIAd+KM0IRYI+xGlw+AX5Dz0LWp7rzAkkRq46/W7lz56HTuEOdWrlgmR1OS9yj5Tyiz/eD6wE519YuQ2+90RL1MvPhMXd9zgNajUuB7kuX/Oh8kK/T0P1NGtxX63dbmGQGQoWZdnxAt4U8ZSzByZbjoWVBvoeiriIXwdSDGmNoPzAdj7Sh8ezC81fCZrNWoayA3Nozectod/d1PUO28/UzzodTy3GAw6jc8NDi3/GmTnsy8ZvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wmy71b0gsLop2I2Bn7rl6W8gR9ZMkBOz2CKWAM+Kg00=;
 b=cMMWo8lydthkdAAiyEpNoyZV/OPcTxH95c3Z+/a/Utih2iFWw92pbgaMRlOIlHcYuBrVD0XsAfoHFMJCdWFyz7sOkz5PbZjYarK6EQfIJ7fRtWsEbsWfFh0pB2fYKVv9wWTWmCOd35mgA7iuRgwTpA0sNLO88wraHo7HcGWVzP7hwBzb6sdprodoZZZW4iuFqX7YvWYwoWNn39LIEyvWAiUG8ot6BSd36XMu2+pUBGzoaKrLWlYh/vrwvaYQXRDC5Xi+zhfUI9kvsVe0SXsVmXUKiVHjmBTyfSzi9uY0AFLmM6Ec2HV5C5z0GKRQpQ6LvBFqrikUi3WBD1hvh0B31g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmy71b0gsLop2I2Bn7rl6W8gR9ZMkBOz2CKWAM+Kg00=;
 b=hKmXguX9tVTeDI5wnS+ZUm3nxAtJ5VF4HEIVSZ2oHZOACrI72O4U/iWo6oT0qQ4+CFm7f2vAZ63VbsWV7sNLlBRCpYYfzP64Fwdr9NrlwDQDYcIMr2NhAIPCjpTsgpRJL5JAiAjfyX9Kb0weYpmlkLOWei8fSYT4+ENN/vASAps=
Received: from MW4PR04CA0333.namprd04.prod.outlook.com (2603:10b6:303:8a::8)
 by MN2PR12MB4360.namprd12.prod.outlook.com (2603:10b6:208:266::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Fri, 9 Sep
 2022 21:40:19 +0000
Received: from CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::c7) by MW4PR04CA0333.outlook.office365.com
 (2603:10b6:303:8a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Fri, 9 Sep 2022 21:40:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT022.mail.protection.outlook.com (10.13.175.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Fri, 9 Sep 2022 21:40:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 9 Sep
 2022 16:40:18 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix warning about missing imu prototype
Date: Fri, 9 Sep 2022 17:40:05 -0400
Message-ID: <20220909214005.1215345-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT022:EE_|MN2PR12MB4360:EE_
X-MS-Office365-Filtering-Correlation-Id: 5454b63e-b4e9-4ee2-9903-08da92abe477
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2ABhjZCXxRmWuY3UBV0aYvchlJVphuun/S2rpohH7PeQUF2CxX/yGKAxkTnU5ZMbRjPc/Irp+VCo7vABQ8H66krtLMp9t41G2Td59r2G0xsUFFEt5oUGbMcpJaHtClnNbIhG54o5qDKvcj0/qb1JwijIttnsuUEXU/s0Lcj7Ulqc4PU3x8Z6XHs6K8p5dMnacmIAB4q8pGInAw9SVQ3RQYSMzi2qeQ+5+U+ZrVdhVca8s7JuhYHfMpfYyKWRQ3RWXRmPAhM9AmUb06osSruesZqZbfnRqs+UeXcVCeJt/uwEir5I+VLUmNdtmTgvwR/ttxWDHgwzWIPvZ/cKvbAqZpCUx4aPQAzRjThE2O0r7hve0rgsRpQD3E93xd2yuFX9H4Z5L60O5SrZmCjiyLR6KnBbIOcRtjGQ3vblnMMJs0gOsW5aaznbA7Y9Lejrn+MuFmn/vnnahheuLRsA2KM97QuvZFTeFNQyo8iGENpEX2OdOUgiKs2I4qH1gDOfjmOcD84D5chP5q6CIRQC0h17CdGaxgRVDR8Ihx09N2jDWgJR2FsRBMf+P6ylxlGUa8nAqz+MJjDq7uXpHGdGrG7XbXKi/AHf4AYxyYoq7A/fBISXBtNfJ/0K+UmeOMchdkGu3R7EXFIa2IXOkGWgSEzIr6BRxsvuiKfJHfhNkyMoCPibWEwFgVXwBdH9ZZjDvQp1xfhbgPywD84CyYSUpFH8M5aEQfMdYhXU8jsYmIeJCqv9ogjAbbwYZb/38g/u9opooGxpXKb3au831MSjneuik8csbpBk/g8J9leu/t0sku8lolKGcLCQLHnnlzZTj3MT
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(346002)(136003)(396003)(36840700001)(46966006)(40470700004)(36756003)(82740400003)(70206006)(4326008)(70586007)(8676002)(36860700001)(81166007)(86362001)(356005)(336012)(16526019)(426003)(47076005)(6666004)(2616005)(7696005)(41300700001)(478600001)(26005)(316002)(82310400005)(40480700001)(6916009)(54906003)(40460700003)(4744005)(2906002)(1076003)(186003)(5660300002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 21:40:19.4577 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5454b63e-b4e9-4ee2-9903-08da92abe477
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4360
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
Cc: Alex Deucher <alexander.deucher@amd.com>, kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

for imu_v11_0_3_program_rlc_ram(). Include imu_v11_0_3.h
in imu_v11_0_3.c.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/imu_v11_0_3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0_3.c b/drivers/gpu/drm/amd/amdgpu/imu_v11_0_3.c
index 536dafb57ee0..fc69c1a29e23 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0_3.c
@@ -22,6 +22,7 @@
  */
 #include "amdgpu.h"
 #include "amdgpu_imu.h"
+#include "imu_v11_0_3.h"
 
 #include "gc/gc_11_0_3_offset.h"
 #include "gc/gc_11_0_3_sh_mask.h"
-- 
2.37.2

