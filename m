Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43DA6C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Mar 2022 19:38:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6EA310E707;
	Thu, 17 Mar 2022 19:38:16 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2054.outbound.protection.outlook.com [40.107.212.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDEB910E707
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Mar 2022 19:38:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VAj71wxk6SS2lBFQpXimeow6IYLxSd+M7uiuNkByVPOvrS/zeHArrUQKaNg5W4ZLcRNaqYli1GSrMdqPRm3CXhkn41eRUXYEsuFTHjRfEWF/LQJRwXzxwxzxKDihDIluSvd+Q+9PdlzkwSLpx/EYzBfGitH8pxhkAUymxx1rC2/gJt66dzqQ1+MSlsVFJoakXmufK6/UHDZXtqtr25/iuxeIVQ1zTYMyyuvtOKattZPcNPugPuZaJZ6rpdyJ/xQSk8wVK+cAtV73HSn6BFSQhwwER6NHK/w5UXGCaPbQ/lDG6mGxtCVzUSATIJtCedvC3hXys+LwFeNzvemWX+Gbgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BXXLZxlp0UdyhaG5dWFgRTHboDYuubVxvEj/CmojSfg=;
 b=TrFzbHqKN6IbF6UyUWO+7+ai2ZlzbEn9J4gZqhOSbER5u1siqR2rRvui8APSrGqBxCU2ya/AxaBPl2sBMMWm9eY3DhR+oEpteKpfvCXv3XeGepy11VkNmMZU/uiIjFYy1psM2zAUqxgrE3ZTZKMMS3gtPZjYEwXBx7bk57ffeEUX1QawaFz3IWcHIMk24/OrTNFNhNBOkkT9SksVMZmg6p+VeZ1kihNJ2b5DVVMVkreWlvmw6ll8U/TKGKjvNEp20iMahxrnbhjDi3H/fWN2Ead5iDx6umVgoaQcoKrfv0FovEqBHL4zViAt97YA08wDC6VSOxHruqWy98YW02z1qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXXLZxlp0UdyhaG5dWFgRTHboDYuubVxvEj/CmojSfg=;
 b=an9h5P5zx7NPpGGLF8Ei/Bh+kBTj8MjudYraB3+Cr3HdBCnfR/78U4HcytKnbBAWtDfSB7PGZGJiV/A6v6rp70wC2KSGHKIF/HdJhEEC8dLhEQU5faeFE2XVYU71yeQ7AAqEBLdLcEX6CVqpo033r8cf+6Uwz8tIEArczprUUQ4=
Received: from MW4PR04CA0375.namprd04.prod.outlook.com (2603:10b6:303:81::20)
 by MWHPR12MB1647.namprd12.prod.outlook.com (2603:10b6:301:c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Thu, 17 Mar
 2022 19:38:11 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::9d) by MW4PR04CA0375.outlook.office365.com
 (2603:10b6:303:81::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26 via Frontend
 Transport; Thu, 17 Mar 2022 19:38:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Thu, 17 Mar 2022 19:38:11 +0000
Received: from tuspatel.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 17 Mar
 2022 14:38:10 -0500
From: Tushar Patel <tushar.patel@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] Fix Incorrect VMIDs passed to HWS
Date: Thu, 17 Mar 2022 15:37:23 -0400
Message-ID: <20220317193723.128232-1-tushar.patel@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3391d718-5cc9-4e4b-1b83-08da084dabf3
X-MS-TrafficTypeDiagnostic: MWHPR12MB1647:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB16473AF4ABB6EB1AC2A22FA696129@MWHPR12MB1647.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MITU0S+52Kq2uL3bQzwgomn4dYrq1XQ+lr9dAcKKt9iAJqIMRW6l7A+sf+rGYTqrEXhx3eea/HWJHaNZdwUIPpgfkKkaDY3SeV6jZu5bknAguoAOHYHMmZABO9JowEQ5zUb1V4IE8i59DN9Djan29WODx70re2NZyrImDu2xsCaueL3VXIEKbBHhNzQJeZ4w4Yt/B7fBeQnw53J7ir/9HtqXp1iBbhP4m9PCoVF/c5fSXNqETp6Cts99uPZomMv0vLFLUZ0JVUFS2dR50HxXDgeG4CgjDjRaJA8oTaMT5yG9tNq5C52MwhjR5aMv234aTg9p4ATCBi2Q9WXEuuobeN2RFd+SgOA6PmF40gMJMxBeX6yqAcUEEAyLvgkhV5BK/fQVqvPXwwhjPYVbAauc5R8fSKOXVVEmRs3xJ/vs+f6hirL4iQkfV6TFFHkrQKiNGCfnfy5Yk9TNDzr3XaihfeojGrWkEkHXm7bQub0Pbx8nFLEBeWtvjjo13ZTGJreuPkEV0gKOwsXDWJFFOAMi8QJKTS6Nit8i9DNcALt+DOHhP8alo1Pddp/SB3F2c6Gt4/785fKvH7yVMhR8sO9nNYHuUEhgLc7Wx1fJY0GG6gRVuSKwESvOJa5zlH7LvVEYxZymaTitzCk1PglVzxyPUURfxhTu5bH4GulDJOENjCu+hCca9F5b4YHZGRr/DiKXAqkoJ8C5Vg6aUoXsV6ydyw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(86362001)(508600001)(4326008)(8676002)(47076005)(36756003)(426003)(8936002)(5660300002)(70206006)(70586007)(83380400001)(44832011)(6666004)(7696005)(336012)(36860700001)(2906002)(26005)(316002)(2616005)(186003)(82310400004)(16526019)(40460700003)(6916009)(81166007)(356005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 19:38:11.4811 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3391d718-5cc9-4e4b-1b83-08da084dabf3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1647
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
Cc: Tushar Patel <tushar.patel@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 21 ++++++++++++---------
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 4c20c23d6ba0..bda1b5132ee8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -680,7 +680,7 @@ MODULE_PARM_DESC(sched_policy,
  * Maximum number of processes that HWS can schedule concurrently. The maximum is the
  * number of VMIDs assigned to the HWS, which is also the default.
  */
-int hws_max_conc_proc = 8;
+int hws_max_conc_proc = -1;
 module_param(hws_max_conc_proc, int, 0444);
 MODULE_PARM_DESC(hws_max_conc_proc,
 	"Max # processes HWS can execute concurrently when sched_policy=0 (0 = no concurrency, #VMIDs for KFD = Maximum(default))");
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 339e12c94cff..39073f72fe5f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -483,15 +483,18 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 	}
 
 	/* Verify module parameters regarding mapped process number*/
-	if ((hws_max_conc_proc < 0)
-			|| (hws_max_conc_proc > kfd->vm_info.vmid_num_kfd)) {
-		dev_err(kfd_device,
-			"hws_max_conc_proc %d must be between 0 and %d, use %d instead\n",
-			hws_max_conc_proc, kfd->vm_info.vmid_num_kfd,
-			kfd->vm_info.vmid_num_kfd);
-		kfd->max_proc_per_quantum = kfd->vm_info.vmid_num_kfd;
-	} else
-		kfd->max_proc_per_quantum = hws_max_conc_proc;
+	kfd->max_proc_per_quantum = kfd->vm_info.vmid_num_kfd;
+	if (hws_max_conc_proc != -1) {
+		if ((hws_max_conc_proc > 0)
+				&& (hws_max_conc_proc < kfd->vm_info.vmid_num_kfd)) {
+			kfd->max_proc_per_quantum = hws_max_conc_proc;
+		} else {
+					dev_err(kfd_device,
+				"hws_max_conc_proc %d must be between 0 and %d, use %d instead\n",
+				hws_max_conc_proc, kfd->vm_info.vmid_num_kfd,
+				kfd->vm_info.vmid_num_kfd);
+		}
+	}
 
 	/* calculate max size of mqds needed for queues */
 	size = max_num_of_queues_per_device *
-- 
2.25.1

