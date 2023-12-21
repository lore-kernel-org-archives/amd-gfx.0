Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D6DC3DA6E
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Dec 2023 02:43:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4C3510E04E;
	Thu, 21 Dec 2023 02:43:09 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B848810E04E
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Dec 2023 02:43:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TC6ewBJqw4xI8Fl88ppL4AC683C5ms2LxJGXHzRrdFciq+X9PpzVhp6493t6jcZUxRKNC8WnF7OkdXc3hXz+Pb8dppaNVpF+2TG/Uj0mpeo0muajlVTGZD+YgEVQKtyx6Y77MMbCTCK9qftze8aw6tZxd+YDzoBOKKcBYLL7sc9BgUDTTxFSI86clIXwXFWuDSmJ5U0JEgsKTmYdCAcyd33r0u5vJN2zzgYMXZWknaUzr060L+W2kHVg4eEDdr+9XXhZn2X3B3DoogNaPFa1lxT2bZCR0TF6RfvWJbIeSPaYXG3a82IU/dQ/cQY/vbQXs1tAVigSjzKKaoGw4hJBPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQfzr9/Hhb6OpQnVLWFt3csODvmVZKYQzv9ehVv986I=;
 b=Sts9FEHWNkvsvGecdufJvNgYFTHUaKn3XCQegyNe/6PZJxgahlF+CsX+zkUb8zRgThrRapTzfTGURESzjjEWlD/JGXriARRrH/MxDINst5WEmvjTNZdUM7OREW6m/ZLgXEXdLKe2ogXOOCm060iBILlhvpSo48EBGvJPfbYF1PAJpkCGrQIrEQ2wObb7LB9iSxL0tvI5BLW/Iz8fHNuoBPZs4545T8rPxmr8e9iWvXxHCtGEEpXfsDWttilEO8xSSouxthFO8Un/GQ1R3/5pxdyr39c8pTQETt30qkQtMq52sNjDYBu2yBz2Rho+yFna0z9fV0hlo2m3xBVSQagqEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQfzr9/Hhb6OpQnVLWFt3csODvmVZKYQzv9ehVv986I=;
 b=iov9gWVE7Z5AArkqccSYqx2ea8eFWk/0VxtT7ShXPsd7HOQ4/j82quglYl96BftBb1U92P2HEvprxguhPHiC8neaLApyhJCr3kSko4K1HfRac3Qcnj2C7xF7dENB0MuYfLPRhVedWhHKfk+GOUKsSY2EpKhC1mEVFrDRGNkeQ08=
Received: from DM6PR08CA0020.namprd08.prod.outlook.com (2603:10b6:5:80::33) by
 SN7PR12MB8104.namprd12.prod.outlook.com (2603:10b6:806:35a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Thu, 21 Dec
 2023 02:43:06 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:5:80:cafe::24) by DM6PR08CA0020.outlook.office365.com
 (2603:10b6:5:80::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.19 via Frontend
 Transport; Thu, 21 Dec 2023 02:43:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.76) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Thu, 21 Dec 2023 02:43:05 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 20 Dec 2023 20:43:03 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Felix Kuehling
 <Felix.Kuehling@amd.com>
Subject: [PATCH] drm/amdkfd: Use logical AND operator (&&) instead of bitwise
 AND (&) with a bool operand
Date: Thu, 21 Dec 2023 08:12:39 +0530
Message-ID: <20231221024239.1150518-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|SN7PR12MB8104:EE_
X-MS-Office365-Filtering-Correlation-Id: ad023d2f-53a7-448e-118a-08dc01ce8f4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /e1emMbGOGKM55BdU0WlgIY0LbKI+HOcK3TIivoC/dPNPDV64VgY4Yffq9fmom1atKwpNihu6pOq+l16nQ0Idl2VmxB8EhaPrmw0qze0zReQqjKVzBNSDDXV/gVE9AmjJ0oiLJS/h8ZWHX/85NDid47P18QO7uv3HXwesj4+Zf7bhxoCpYBGmPi1yhON+lnj6O1+uMss1hoUcXf+9fn7wq/ZpJUrsNsyFqSeGp12LORXc6nLr1Xn4Ac+TZ2M0KSGwssOeWpRIZwAvtwi5Klt4Nie2kb4uyDcMS9pkpOqJnwBr0Egwb6dz+ifRfISgzTjPIiBLigMuE2QNbEAIOVvrkfC6P6tzKVsAL78YOqVEv88V1Se38CXQbsdXGxMsPV+qMC2T0kGvTALZXL0f5Lgva96U7Y1pVKRux2QyVfinJRM6tHET3pCMmCNgWKWMPKVjUlszUxs6o4t+N0b1WlV0kEbUbXw1S4MXAFZAIR39RvfS5AcwQVWnuaRxY2LrS5IjULgGC9q4T04M5rlOyb+XDxGu+a27qTbJCOMtDkDn0jU20YQi/WxfMlhsC2MNdOG6hEP4hAAfyPnq2d2C7jIy64Nt/jVnbiBejvXfkwX5IYIclUdtYpemYa3/A7T1aS7cGgtlVMY3iyc2llPY+9QYO1b9qli1g/yJxRnhZSezDaDBxMKQeT7NR3WHswgu5bWSzxEImZ1Wm5tsKtFc8RvBFX7B9yFKHuLVyPUQBHx1HprMjkOGDMXIg8m9HII9iFtK+xPRdNAzLzPnrxJCj5pwQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(451199024)(1800799012)(82310400011)(64100799003)(186009)(40470700004)(46966006)(36840700001)(4326008)(8676002)(8936002)(2906002)(44832011)(5660300002)(7696005)(6636002)(6666004)(478600001)(54906003)(70206006)(316002)(70586007)(110136005)(41300700001)(356005)(40480700001)(36860700001)(47076005)(86362001)(36756003)(81166007)(82740400003)(40460700003)(26005)(426003)(1076003)(336012)(66574015)(83380400001)(16526019)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 02:43:05.7823 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad023d2f-53a7-448e-118a-08dc01ce8f4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8104
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Doing a bitwise AND between a bool and an int is generally not a good
idea.  The bool will be promoted to an int with value 0 or 1, the int is
generally regarded as true with a non-zero value, thus ANDing them using
bitwise has the potential to yield an undesired result.

Thus fixes the below:

drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_packet_manager_v9.c:117 pm_map_process_aldebaran() warn: maybe use && instead of &

Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
index 8ee2bedd301a..da83deee45a7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
@@ -114,7 +114,7 @@ static int pm_map_process_aldebaran(struct packet_manager *pm,
 			packet->tcp_watch_cntl[i] = pdd->watch_points[i];
 
 		packet->bitfields2.single_memops =
-				!!(pdd->process->dbg_flags & KFD_DBG_TRAP_FLAG_SINGLE_MEM_OP);
+				!!(pdd->process->dbg_flags && KFD_DBG_TRAP_FLAG_SINGLE_MEM_OP);
 	}
 
 	packet->sh_mem_config = qpd->sh_mem_config;
-- 
2.34.1

