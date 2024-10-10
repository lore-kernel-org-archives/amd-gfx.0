Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B46CF11FC
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Oct 2024 15:18:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D20E210E958;
	Thu, 10 Oct 2024 15:18:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ydoZepxP";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2047.outbound.protection.outlook.com [40.107.101.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2D4E10E958
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Oct 2024 15:18:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=imBxZBqhsr34UeF0bUBOh4Az824meLqaPo4R5lfYR4xjQIP8MiELfzb4BGp0en12isLt5los2hV5hvuD84e2lP/WFUHrlEUV1Km6e1bjFRyH6/w53CHJdOy6B5KQFMdkZgX5L0ND2c1xq+fg+1323hYn+C7uP50kttB0til8vNNN37/ObEmkF5Nb7l0kb5TCcr5a02TwsZC4N91k/W5elW2BD1OGptaUGeGPo92La1O6ive+lMCIIWCSGTWnFdbjJehORWzj3I3lln2XO6zupJ1jNxaAeVAklgqmUf1zraNSAbm3NSEJYBp+a2VnZwGhi801PpUa9XzXcciJOodsrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pDumY++SK2JEbesWBkntmTLo1DV67NP/QI3RYR6l3S0=;
 b=iw2Z3e59xVf6OyN8lvFUgOOeriFY0m3Pj77g5xNV6BR8qU+uiOmG3ek5hqbHU0HDaluVK4zalX4PqzO3ub1vzYlNpo7xK5mE/AUWkcOWDlP3zttqErFtMAYN/JT9qvmh/nD3bV3zmXD3FPS5RM2GWAM1TS6v/A7OU8fO5oOSqc8JuMg9tOP1lDylX6d14GT1GgmUNQwv0JgoJWfGRPWNsGHuvmJCr9ABIvdEKbmIlODQTSM5yuL9GGJk7sGOlXZuVuRIJcZY8kDAhk4WQqQgWEdIMyVPctNOyaRbnzMSiEUmo6/nCZXXTFzVtCnFjCRDRkQDGUKN5niaHTPOmenluQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pDumY++SK2JEbesWBkntmTLo1DV67NP/QI3RYR6l3S0=;
 b=ydoZepxPE865TzOAhbhi/MAJH8orrfBn95WTS5gP5ON3OcxZG9lhpbb5iO8KvB0fUZN0OUw+Eu6oahtSQsPDA8HlkQXBAV74rddFWKB1ys/ocI/MyTlvvFcAammJH9pWwfdXdbB1qTw7jL0EYLOctPuH9uj0gry/cF8sJlSNs0c=
Received: from SA9P223CA0007.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::12)
 by DM6PR12MB4385.namprd12.prod.outlook.com (2603:10b6:5:2a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 15:18:48 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:26:cafe::e9) by SA9P223CA0007.outlook.office365.com
 (2603:10b6:806:26::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18 via Frontend
 Transport; Thu, 10 Oct 2024 15:18:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Thu, 10 Oct 2024 15:18:48 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Oct
 2024 10:18:46 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>,
 <jack.gui@amd.com>, Yunxiang Li <Yunxiang.Li@amd.com>
Subject: [PATCH 2/2] drm/amdkfd: pause autosuspend when creating pdd
Date: Thu, 10 Oct 2024 11:18:31 -0400
Message-ID: <20241010151831.10859-2-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241010151831.10859-1-Yunxiang.Li@amd.com>
References: <20241010151831.10859-1-Yunxiang.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|DM6PR12MB4385:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cc4f27c-8e4c-4f8b-ab4c-08dce93ed6dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zsgXFdx4QMrmb69ftQW/r8d9+joD+DBvKN39xpOyVMdUSQJfSzecV73sNYM6?=
 =?us-ascii?Q?G61UXsbbGkcge8XBvN1EzhaLMfKjwfCVIOFNbjfOp6XfKUpqBqR/o7aeOqu+?=
 =?us-ascii?Q?FnlxVr72GZFjUny1bWMdtk6RSfQ6hOg7Wl50PXJoJRhGGhPygem/t9JNr0tR?=
 =?us-ascii?Q?1NcuprHIUGEMwkpl1ClIezcmLGII/lGCDuON0VIimQKIuba2tR617pXuDGTS?=
 =?us-ascii?Q?aglKDMbiKTakbzDh17wxAwo5jB0/C1AqN3o8SFclOsSVR6dN/F184Onok46z?=
 =?us-ascii?Q?prt/8a1ChgOiawfp9O21jUXGh+IAx4q3YREWl34PKXGkoQbyNCYzb9iJSUVk?=
 =?us-ascii?Q?Lc/zqMDhBh/DiZIBtK17RdTiRCVfG6QYTGyBv6u2vepul6jt7HFH56+DVpFi?=
 =?us-ascii?Q?QOo6GchXpU3fw2p6iFPn2aQOC7wxErfJXnkx1Q3zVbxVu6HKhO2xbTEA62kP?=
 =?us-ascii?Q?fDTkouUdOvzT2t3aNDkVAYgasBWIcWxP1v8u5VoCHplumpAjlboZhvyTQH+m?=
 =?us-ascii?Q?KXOTxdubNntC73yCHngJbhFS4xXW5OqPCPd2uKdxvP8GWl8D3sDrL9z5MgMI?=
 =?us-ascii?Q?Pb0m72dIMODOFnYF9XGn15uaXfs8s3KI849PhZmsYJ9Nzm1w0lFEDKaQhg9v?=
 =?us-ascii?Q?uhFBkWUSOCLUprcngVPt5sdO1+k3FCHIQ77k5zFhoEY6OdXhwGfORDHG761j?=
 =?us-ascii?Q?ppGNt/nimvJu0enDZzc/h4tzK5tdyRNuZDH+2/3wrp1tXPqc4vb2v4H2LXQi?=
 =?us-ascii?Q?wKwloscIqTCavyur591g2EbOQ7I3qbC6vdOWQXFNziPISpP+l7nzozwmbCzn?=
 =?us-ascii?Q?3X4+/9BXE1N8DcTh6fXlZDbWiE/Lqm2cXd+WkKVBE1wGLniFMKMK05IeG2LX?=
 =?us-ascii?Q?jT59qkI4iP7HKgeiTqXFFTizLdZL6HJAS48S9cPTKCUXAvtlK3Hmi76zmgpF?=
 =?us-ascii?Q?qy7VRytBfFYRuC7Sh+DSzO4l016f+O2pliVLSTChQWun4EQA23rwptDDgJME?=
 =?us-ascii?Q?F3kVzGL1ssDiz4951lRPI5tSseeb8Rp7sQddgg6GuPlCWHuhsbqn3avyVV41?=
 =?us-ascii?Q?cFFAKwg12VESqEEfJvud1pM0fzkLG+wwbaEbM0Db/5NX13YQkLVBrZGUGDgE?=
 =?us-ascii?Q?M74B25AAPPP6cpy92eZVbKBShwvRpCFKkweACgwiKD7LrXGcuccn2lCPLooe?=
 =?us-ascii?Q?PPC9aK4rHIwJMmY2vmevBV8GDnHqjSliMqi+8ChIQxdINxcmgltBJ7Gqcr5j?=
 =?us-ascii?Q?c7pKHchCXsxFQMluXSRt+cWVuVmFIijpre8Mf8PH5arGePNtZmuJkm4E3SS8?=
 =?us-ascii?Q?aQfxJbe9pyHiVhumJOfYyPm5hRJgW6L24FtBIoHRx4z22OQRHP5WpH4DLoX+?=
 =?us-ascii?Q?KGMDpNN/fC2hI6WPtEkZdeir6Mso?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 15:18:48.1082 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cc4f27c-8e4c-4f8b-ab4c-08dce93ed6dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4385
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

When using MES creating a pdd will require talking to the GPU to setup
the relevant context. The code here forgot to wake up the GPU in case it
was in suspend, this causes KVM to EFAULT for passthrough GPU for
example.

Also, change the other place where we pause suspend to use the cleaner
pm_runtime_resume_and_get helper.

Fixes: cc009e613de6 ("drm/amdkfd: Add KFD support for soc21 v3")
Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
---

It is unclear to me if kfd_process_destroy_pdds also have this problem,
or is freeing gtt mem guaranteed to succeed even with the GPU in
suspend.

 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index c334432e55b14..618afec5caf8f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1633,6 +1633,11 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_node *dev,
 	atomic64_set(&pdd->evict_duration_counter, 0);
 
 	if (dev->kfd->shared_resources.enable_mes) {
+		retval = pm_runtime_resume_and_get(bdev);
+		if (retval < 0) {
+			pr_err("failed to stop autosuspend\n");
+			goto err_free_pdd;
+		}
 		retval = amdgpu_amdkfd_alloc_gtt_mem(adev,
 						AMDGPU_MES_PROC_CTX_SIZE,
 						&pdd->proc_ctx_bo,
@@ -1642,6 +1647,8 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_node *dev,
 		retval = amdgpu_amdkfd_alloc_gtt_mem(
 			adev, AMDGPU_MES_PROC_CTX_SIZE, &pdd->proc_ctx_bo,
 			&pdd->proc_ctx_gpu_addr, &pdd->proc_ctx_cpu_ptr, false);
+		pm_runtime_mark_last_busy(bdev);
+		pm_runtime_put_autosuspend(bdev);
 		if (retval) {
 			dev_err(bdev,
 				"failed to allocate process context bo\n");
@@ -1771,11 +1778,9 @@ struct kfd_process_device *kfd_bind_process_to_device(struct kfd_node *dev,
 	 * pdd is destroyed.
 	 */
 	if (!pdd->runtime_inuse) {
-		err = pm_runtime_get_sync(bdev);
-		if (err < 0) {
-			pm_runtime_put_autosuspend(adev_to_drm(dev->adev)->dev);
+		err = pm_runtime_resume_and_get(bdev);
+		if (err < 0)
 			return ERR_PTR(err);
-		}
 	}
 
 	/*
-- 
2.34.1

