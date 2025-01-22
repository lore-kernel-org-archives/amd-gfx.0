Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E578C02182
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2025 09:26:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C29E910E2EB;
	Wed, 22 Jan 2025 09:26:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RfUAiQP4";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2407::61d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9ADA510E2EB
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jan 2025 09:26:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KGl6ayud/E01RRqQ2GMu/2hAxcvLJPOO5PwfTK75SoMOiCvPMNH8DaFoTN5UIH1ATS8dDLl1EYpCxcuEPJXribpuXqERAm+nxjsx2MT9T4ejOQiP2KDlsZ//Uk9PTw4WpfGGVvpTruHloNpDiB+/2q0UAXgXrrRkvYvbjSZEjIXtpavpK9qD3jeTdzTxPkMJahNV27L1htNRWg89eaBgbVvubtxisx0SxWvbbL/Zc9IHGkS/3F/dWZufwrWVyrB0c5ppTpxLyYl//kgyDJbHkAfV2CSwkoXBThccwRO0mCMIrQUaTfG4F6Niz8ToA7BSskwgsT4enlQ6fvE3T77V9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PrljImpNo2UM2LWLhrMQXDuK3BtudnfgHWtvyKDWz3I=;
 b=fTfaBu48NOcE3RsgCtlsfORqUkNnzzi0dT9gjyvzFVc+vQtaXb0gG8/GCYe9OoLUcErelhnxS1zKD61aJD3aCuFXtPAF2q2/qzueSskvGM6WegqycWwp+I7jRVdS1UapMfghhhrdw3z87uiJa3WfI6GIe/sERY2rtdtZHgpd3eL9fwfrdONq2yEmVe61873sV5Nv9ofUwPQhbY/EHCodSvfLj1PeU9QfamOnVs71aZslN7FQDFVuiEar2HO8NgGBqRAPb8w4foBdGs5R+l5mcns/+EnrMDEHexNHn8rRoqRwu3ducfyux5zm3mdRsb8J6mWWeGPkA5B8KKwF3hzP7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PrljImpNo2UM2LWLhrMQXDuK3BtudnfgHWtvyKDWz3I=;
 b=RfUAiQP4nDiv5de5DxV4UIHLfZRce0Z9jr1rYw7vtUINDmDrmiyDoewScD5gw8g/Z3evrBSIFvjuiSyPtpNK7yCw5g9btz6z52++lMPutIE79PhPmf9d+jgF0Z6gOS/mjgRi1R4/8FgPs+XLf+Rk8MiOqcltoRJwSIy4LmWU96c=
Received: from DM5PR07CA0062.namprd07.prod.outlook.com (2603:10b6:4:ad::27) by
 CH3PR12MB7690.namprd12.prod.outlook.com (2603:10b6:610:14e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Wed, 22 Jan
 2025 09:26:14 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:4:ad:cafe::ab) by DM5PR07CA0062.outlook.office365.com
 (2603:10b6:4:ad::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.14 via Frontend Transport; Wed,
 22 Jan 2025 09:26:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Wed, 22 Jan 2025 09:26:13 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 22 Jan
 2025 03:26:11 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Christian.Koenig@amd.com>, <Felix.Kuehling@amd.com>,
 <Jonathan.Kim@amd.com>, <Harish.Kasiviswanathan@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdkfd: only flush the validate MES contex
Date: Wed, 22 Jan 2025 17:25:59 +0800
Message-ID: <20250122092559.3317767-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|CH3PR12MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: 184d8195-fb79-4408-6102-08dd3ac6d0db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cyiUZDyv6DdyTqBbu5ARtsVHq+fe8RE0PDOGm/sHd5+MWwI7kvwNbGFxl7Ez?=
 =?us-ascii?Q?CWmjpKksBruQaIC11VGEo9D4Puh3TLwc6fdCmoXus3lWN+ajjtYasl9hI3u8?=
 =?us-ascii?Q?nqosYwM/yo2vicXaGhUwUi7Bn+k2EI3RtN7GpSSZ6IwFk5P+rSkn1p4YiwpQ?=
 =?us-ascii?Q?1Ey+BwcrDG8NkEnah0no9BmgPzqe25GwBScfNvAtH16JeU7r//NxeD7yLKP6?=
 =?us-ascii?Q?DAzsw/kDiY36vo7kVIQ/fPYxCaQJiAmle837EALfc+cFii2vW9UKUUob8Hiw?=
 =?us-ascii?Q?uJ0sjxD3IrQVV7rQf+wSXfZCgFu4ntFj71vErDu6FmlnEFPwS7j8BAh/TXw3?=
 =?us-ascii?Q?kbScq/3C2cb5WLn4t0YNskPckBAsrL9zUuIst1alSJDhGjdi8BQJthk3swCE?=
 =?us-ascii?Q?x0PFVVlNMKpoMgAazP6t0tirxbuBmjiPNL5HJ+imCEd76GuYKwrz1Qj4ybOM?=
 =?us-ascii?Q?kjTtlfARHYhkX0LVXdTuIAUsCFMgGB/uf5ZHgt5hc54BVJdZRIDf00XwL7gH?=
 =?us-ascii?Q?7UewxX+MQWJRus3R/nmB5udoPRyEwrauXdlHsw9piNZ4Zb34nKqHT9AqRy52?=
 =?us-ascii?Q?5YSNVwWgNFFiVX89HGPzxfROcWhyiBGhEcBVdvFUQP1APUCh9Ez2rRiA+F7I?=
 =?us-ascii?Q?n5jtadMWQ/O6/Cx3IKAc9Hmes3iL20cZyfSHB3F7F5JQESAsNrGlbV0LIfv6?=
 =?us-ascii?Q?+3W0UlHWHbvrnKqe1hYJnNkLT2s0kRXSVxFb/q4uO9UyGoJf8yE7eYoMjYDq?=
 =?us-ascii?Q?VKkymuawmxXxXW5HaSL/0W5P39/bWAjd3yW3iUVU7V6/sp/SUTyIkXJvo38r?=
 =?us-ascii?Q?OP6bX0KyRRDVOrni976tqRM/RsGOlkDJg3YZiBnrJkcHWoEbqiVrioHHyqSi?=
 =?us-ascii?Q?JzPb4RPLR2qU0x+WlePKZL0+9URp+F6Eg2jTUZN/LbGJrWa3mqaC+BJJif+j?=
 =?us-ascii?Q?DdkkZgumTbtTrN1zRpzKohXsc5bmFHTOEMj3E2xKyPUrcRVALs/TR734H3KX?=
 =?us-ascii?Q?UBzMig3fok3FEjd9wdLac42AVvvmBeLcY3QAwa+z8/xRMQRqSTQpW3HoSy2m?=
 =?us-ascii?Q?RQfMFIF11IrZjgIerUsjHWHQpBM66S4RqN0x0/TyWe/PvkCi2c9Ux3wovPmj?=
 =?us-ascii?Q?y2r76P4OpaGUn9nDJ3EleNKoVFO9jdZI8zySHRpd8IR68bsiyM5+G+w39L3S?=
 =?us-ascii?Q?XeOOxBFsAeRXESNhsGO7wUQKZfR96vvMnTTBkfplpcAOWW5VH8QoDrSCIVho?=
 =?us-ascii?Q?KcNehh/PxZnGeMpLbTryoGPNRQQbL8cA0OhjaDhjUTNt28ycdTC1z2EdBwHj?=
 =?us-ascii?Q?Ta3Ddb8zlneFqmAZLKd7RttzZobn7aHMPP2Syjqr3OTbPuMEhb/qHuYmK/1E?=
 =?us-ascii?Q?bCtrBc+xWpgSwbSJRPTineMWY+CTD1t3VxyZBzCKU/hmrxg92REsLYFXzmU2?=
 =?us-ascii?Q?IAjHFPqiBpluRczAfwjU5bT+om0zpdSl2XDSwjXiaIpeusq6by4Wxg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 09:26:13.7358 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 184d8195-fb79-4408-6102-08dd3ac6d0db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7690
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

The following page fault was observed duringthe KFD process release.
In this particular error case, the HIP test (./MemcpyPerformance -h)
does not require the queue. As a result, the process_context_addr was
not assigned when the KFD process was released, ultimately leading to
this page fault during the execution of kfd_process_dequeue_from_all_devices().

[345962.294891] amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault (src_id:0 ring:153 vmid:0 pasid:0)
[345962.295333] amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x0000000000000000 from client 10
[345962.295775] amdgpu 0000:03:00.0: amdgpu: GCVM_L2_PROTECTION_FAULT_STATUS:0x00000B33
[345962.296097] amdgpu 0000:03:00.0: amdgpu:     Faulty UTCL2 client ID: CPC (0x5)
[345962.296394] amdgpu 0000:03:00.0: amdgpu:     MORE_FAULTS: 0x1
[345962.296633] amdgpu 0000:03:00.0: amdgpu:     WALKER_ERROR: 0x1
[345962.296876] amdgpu 0000:03:00.0: amdgpu:     PERMISSION_FAULTS: 0x3
[345962.297135] amdgpu 0000:03:00.0: amdgpu:     MAPPING_ERROR: 0x1
[345962.297377] amdgpu 0000:03:00.0: amdgpu:     RW: 0x0
[345962.297682] amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault (src_id:0 ring:169 vmid:0 pasid:0)

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 9c2d8393cd4c..c39cdff58418 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -86,9 +86,13 @@ void kfd_process_dequeue_from_device(struct kfd_process_device *pdd)
 
 	if (pdd->already_dequeued)
 		return;
-
+	/* The MES context flush needs to filter out the case which the
+	 * KFD process is created without setting up the MES context and
+	 * queue for creating a compute queue.
+	 */
 	dev->dqm->ops.process_termination(dev->dqm, &pdd->qpd);
 	if (dev->kfd->shared_resources.enable_mes &&
+			!!pdd->proc_ctx_gpu_addr &&
 	    down_read_trylock(&dev->adev->reset_domain->sem)) {
 		amdgpu_mes_flush_shader_debugger(dev->adev,
 						 pdd->proc_ctx_gpu_addr);
-- 
2.34.1

