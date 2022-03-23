Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F0C4C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Mar 2022 18:11:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE8A610E069;
	Wed, 23 Mar 2022 18:11:56 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A4D310E069
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Mar 2022 18:11:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mPSB9/ce9p5D+rYy5a24VrxyQkYxiFxuBNU6B86g7MhBrFXq1cwORHiu8SxLH94JNLHYD0BJxPPUsnGUTSEml6KWrwCp1UDfpUwTaSEsE+T78Ph+vwblCKXKVSmNsmOG+FXtS0qyoekDYZsl/UwFxjFn5u/RAZezPTvy3QMXuiNfoxUYalD5P9voWsGxGJmtZSn9+TtahYlFeKebnYCyJfd91yLLRgtetpn/PDYfAFfvsy3ZLfF1LNpdQl4b80zG5/YeaBedcA4s5kSPqz2ekVPNy/BhS6aRRUuBQBMSOo3C3S10ASVeDhQGUS94e8Im2wSs9sC3bIWAOXMufWey6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QvE7pqarAGyHJwWDaTpDjkJ3dRQ9yAMrHA4WruBHlTM=;
 b=SQ6WWr9qWZz7akRLr91di+9KCz9Wsb0oNFH8bK6iXltsltcHH9QOUsgAy8yX0La4P+HK/gBjeptsAFbMTtlAyV5fWZxS1pUNmx7AaXk4wleUhPKbAcKy15+iCC/xUnjOEdX5+lAaa7Rgy1MaGbk7reK+PR2TYMoi56AnQ/DbvR++N9GbX6Me6ox3xlXXcmaNj693JrsfiD8vC1iaaiwh/mIs3qIlRt5CWAF6XJc3/oe6IDnDKfRpFLcoURv7+YitmiiG/mWQ+ubaecpE/x3d1vZPwji/chKQe7Mo+O+/GJuKKeuEZI5xjzz72IXIuaJ4HbI0v8uhZ+o/rvk4y5qF4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QvE7pqarAGyHJwWDaTpDjkJ3dRQ9yAMrHA4WruBHlTM=;
 b=FwxEPhHxOBKqlLppRCOkagc1zLIYcG85ZlazVcDLIs8OT9BUT6/Lw2+e90HEnqtdGX5Oaq8ffyKgNPEAo/3XzWVLrSZ3K/8jdS0t7u0nQfaZ6YgVHIGZvJmiN/2BoujK6Pw3It9X5hady0xv3i1oz+SODDIg1ZPj4wheiAnE5wc=
Received: from DS7PR05CA0081.namprd05.prod.outlook.com (2603:10b6:8:57::6) by
 CY4PR12MB1464.namprd12.prod.outlook.com (2603:10b6:910:d::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.18; Wed, 23 Mar 2022 18:11:53 +0000
Received: from DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::42) by DS7PR05CA0081.outlook.office365.com
 (2603:10b6:8:57::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.8 via Frontend
 Transport; Wed, 23 Mar 2022 18:11:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT019.mail.protection.outlook.com (10.13.172.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Wed, 23 Mar 2022 18:11:52 +0000
Received: from tuspatel.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 23 Mar
 2022 13:11:46 -0500
From: Tushar Patel <tushar.patel@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Fix Incorrect VMIDs passed to HWS
Date: Wed, 23 Mar 2022 14:11:20 -0400
Message-ID: <20220323181120.110652-1-tushar.patel@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68e4c1e6-7377-49db-6800-08da0cf89b7f
X-MS-TrafficTypeDiagnostic: CY4PR12MB1464:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB146411F22A5DC4BB97D4D3A196189@CY4PR12MB1464.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tb+4QBCcGusRg7umEBW0jzuao+jfT2UDUfbNGlxy1eqXzrw16IxxJkEr+x0LwYsziI81f3MDQFC3c2oCEHg79jXrBme/G6XlGSugAoGSYQLQUNXh53aRzrtsTVhzwvfQpEsObEjDgJNQDsqPgQFfMYy3D39WfouzdU3SZIeLbMUkZKRXvcJDKeYciDMFQB8Urnh6+pO+W5kZBhFssnN7EK9cGyYSF5UaZS1D1a+2E1BswvGGRURzOZI0dJQbGqnjq13DlEwZPgXWuiG/cvU9IPcOysiyo/7LMKd9/CmtBEPniwfxYnXZfB/bw5tcvoB+jU5tswWB68dX+r1rD9Oy0frvQ+q/ZBk30xgbQhUQaNmyEIUfiiUatkCXhA7X0d78EP88Ek+YbWkFH2GFIITiNB/rpV1wxZsuxBtqTD9xnPI5qtta0GYh1yunwSzpN3//s9yH41b0iMke40kCyHkrWKLI6Co3d2hX6oVACa4QmYeCzqNpc6trb2JLTNbFni5MQFuu8xJudg1QRMBZmGKTrXLsVhN/P256JfYtJXOja+czy7vdR2FMg0+Bh9i4KBE1sYj+PgO4WtlDHQSMPqBLZE9fHtFJv8E3/6Ji49+1sHtyEr6Gyilfy9eUBgluNtjSJucoO5joTq8SjC3DO4/+t7ZKDrLxzD6znRb/k8+nw0Ls8SIS/CrMzS0HUkqe4xPZKHankrfEUYgqkcTWnYQRAQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(2616005)(26005)(186003)(426003)(336012)(16526019)(2906002)(47076005)(36860700001)(7696005)(36756003)(82310400004)(1076003)(6916009)(5660300002)(8936002)(81166007)(44832011)(508600001)(8676002)(83380400001)(70206006)(4326008)(70586007)(316002)(40460700003)(86362001)(356005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 18:11:52.5649 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68e4c1e6-7377-49db-6800-08da0cf89b7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1464
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

Compute-only GPUs have more than 8 VMIDs allocated to KFD. Fix this by passing correct number of VMIDs to HWS

Signed-off-by: Tushar Patel <tushar.patel@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 11 +++--------
 2 files changed, 4 insertions(+), 9 deletions(-)

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
index 339e12c94cff..0978e1145995 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -483,15 +483,10 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 	}
 
 	/* Verify module parameters regarding mapped process number*/
-	if ((hws_max_conc_proc < 0)
-			|| (hws_max_conc_proc > kfd->vm_info.vmid_num_kfd)) {
-		dev_err(kfd_device,
-			"hws_max_conc_proc %d must be between 0 and %d, use %d instead\n",
-			hws_max_conc_proc, kfd->vm_info.vmid_num_kfd,
-			kfd->vm_info.vmid_num_kfd);
+	if (hws_max_conc_proc >= 0)
+		kfd->max_proc_per_quantum = min(hws_max_conc_proc, kfd->vm_info.vmid_num_kfd);
+	else
 		kfd->max_proc_per_quantum = kfd->vm_info.vmid_num_kfd;
-	} else
-		kfd->max_proc_per_quantum = hws_max_conc_proc;
 
 	/* calculate max size of mqds needed for queues */
 	size = max_num_of_queues_per_device *
-- 
2.25.1

