Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81267D2C555
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Oct 2024 13:51:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3881E10E687;
	Tue, 22 Oct 2024 13:51:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2i6gVP2t";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86BC110E687
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Oct 2024 13:51:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZlAHn7Yz0U8JDySl0a6I8/9pEjnAj/KYXHrmDouhCAnnZ3oRurzw77vwXI8OmF4TO5wXNf1IYR3klx3K7L03LhlZ9g0fD5dQChkVNmEIpQtNurswoeYlQ6jMbh/nHMqjPj/SAGit4gguGIq2TWUoQ0ZltoQrM0ZIaII0+cb2GSFwV8AtZQ1dR/Zm2bmgcwFwpZ2bTiQPoq+0l+bksqNGFAt0nQbXSnYyT2WFl4kI0Nd9Lz3m37G0RuJ3deckQzJzDraICTZMMYjH4ALMGZSjTtrBcJRfk6YNfjNaSmr+nTk3yNsg94/ZVih0rkBS5wsoytifN47o3QltrxGidb2/WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gMzK85zBeBdqAt4EYI9DD6H7cjuwcWVMVZ+UPOu7vk=;
 b=dcjxdoT28IWWsPSoxJAUgV+3YJgSuQQINtQiVNZsNsMsz0orVnLY04foyxyHWaGkYvZWTZZCY6FQGjlhsJNMHVEB/o76kpQRpmqhtSr497t2ahzTrmGAPXSfgaZ9U2j2raBTA5ev5VNOnp/VJA5NWItLhYspHIiTIb0lso6Mo7jvi51KcCQHJBsrzt16me1zmoc6+FI0Rx2QTToM9qgt+zu75N3NBkiEyrLTatP6LZ8f3e76a0q9vGbJU5A8H0ifT9AWUTmGsyJk4XQTwzAYU8V0/k/gG+0k8DPiCHZizOOiFptjftFNBceTc6dAYB7pkf9PBJhLNgwZexrdiyVKTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gMzK85zBeBdqAt4EYI9DD6H7cjuwcWVMVZ+UPOu7vk=;
 b=2i6gVP2trsrbKACuAKPT8VLhrYHYjwyHTB2h8gHEaKcO6YNeDH7rfXD3c09vqQgYhPCfg1bI9nN7D8mS6tgJf0efXqtlT1WM3ORemh0ep66TYGv+2JJqk+Jrq93qvszR/jLkEWEi6C1Ic6HJDNx6MptMNEKft00NUM3gZYVXPIk=
Received: from MN2PR11CA0004.namprd11.prod.outlook.com (2603:10b6:208:23b::9)
 by IA1PR12MB9064.namprd12.prod.outlook.com (2603:10b6:208:3a8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 13:50:59 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:208:23b:cafe::7c) by MN2PR11CA0004.outlook.office365.com
 (2603:10b6:208:23b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Tue, 22 Oct 2024 13:50:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 13:50:58 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Oct
 2024 08:50:57 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Kenneth Feng
 <kenneth.feng@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH] drm/amdgpu: handle default profile on on devices without
 fullscreen 3D
Date: Tue, 22 Oct 2024 09:50:43 -0400
Message-ID: <20241022135043.2638637-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|IA1PR12MB9064:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a989457-2ee1-4c91-19fe-08dcf2a08f27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LINvHDUX2CV5cAVihF16oJxR7u4wNGpOkJXCfoPsYIHG37ncrVYCGq+/J1Ho?=
 =?us-ascii?Q?eGU5ROnNpzr71Fnlie7Z1Xliw7TMhJPYv3qO+Zswi4ZD1MVpwusIK+dh/7wz?=
 =?us-ascii?Q?3n8DTlitMioEUprRWUpTgT4FOE2O23v1TG7seTwW503ZR6vGchlvZBEjgbOY?=
 =?us-ascii?Q?m8jrTSjZAsG2gT+PnmEO3TNglLGdF5zbPOQscFNrBpbXOLBFjmNijyWEtgZ3?=
 =?us-ascii?Q?CxcGYRtYJ7H0Bnf3LiVLvewKGnLWlyu1UBzm8bOv3ljVqsLsWAUtCNmMWChj?=
 =?us-ascii?Q?hKJ4LvrauLXTb8eRMzoFa1cYUlWC8E4H+O1BkdLLWrzvVgHn+uAXM1VTOOv5?=
 =?us-ascii?Q?A4WnUgjDH5nf6jxrC48nedSC4M1h6AGbMvpB+YK+pLBynrzMMCmpPIgz+9P0?=
 =?us-ascii?Q?coVIc5jDiIBcloHigYAAEfcQOSbsutHvdtGHHSPNZ+MyZbcpddSOvf9XAwh6?=
 =?us-ascii?Q?3G3339wphZ0pTXSk6a0VRGbLzv6j7ylMPQ9VqMWeh17BPMOFQJYnWaMb/bWS?=
 =?us-ascii?Q?ffxyEreaSEYgyq8jolFfJTWOgDoWZIjvWpds216xOvG2dNo51btaYB0zipmt?=
 =?us-ascii?Q?cu7eX9B81mqrmmLKwD6z11SGH7eahf7pnn4oR7ppg5U9wpyme+U6kWHjSm5v?=
 =?us-ascii?Q?CCOd74K+4A1cLoDqC5AMkSArs/XO8ZWrN9k2qUw08YAo1UEBO3uuoO0U7D+Z?=
 =?us-ascii?Q?XyNxIc6kVd4c0eSJUu5EiinzsQQaoqqMhfcnvXQaxnI2sLrMyaa4UvMVSy5M?=
 =?us-ascii?Q?Xe6gXrEjM0TGJrTo9WUF5SewCH3ZlcO0QeZFjahu3CD+AwkZodTFmsm5LPEu?=
 =?us-ascii?Q?OhaLho9AORByVw+NhqZVTcVrEou2MrHmIcENhR7ToUqDqDI8kmbnKbC8AAck?=
 =?us-ascii?Q?7qPmB30vc/OnJwOz3SQb4Nk8Yk4wxqteBZbMEabJhK28EvUsdhCgZJEDCmuK?=
 =?us-ascii?Q?NZOKnTu2tsn20Awa6gzbp97W1/2JMuCv1snxnj/w8FhiXYVrJoD8tGOWxHCy?=
 =?us-ascii?Q?eXix9c5CXs6JFy7tuLFol54Cc7ZJ4/DnkTIzZPvnGWY5U+fn4KqvznvciWJb?=
 =?us-ascii?Q?uCG3ePSbsvDbn37Epizu7mCIe8mD/axXMMoFiwmdw1NYcAPiziNw9SA3OKrN?=
 =?us-ascii?Q?rmBed4nFms4sxFnvaXTf+WoaNQ4KPIFJk7cJ7wzqOLAV8zJuDdihem2s5H4L?=
 =?us-ascii?Q?1ZUgvEwkUYqNg1mPnD0ajTVVzxQL+We4GW8KBg7bCGHWzBE5LaayqTe/L0c2?=
 =?us-ascii?Q?H2t/mzaSMhjlhn6s1o79wi88jgxfSgUqhryibvks5/cNOSsDVM/iLP5ZRyXN?=
 =?us-ascii?Q?5Ovzg+J39gYfdEa6grOSoZ9vQfmlvBQKgPvlqiX3sMRBxiyuuvKwdfg8Rpxh?=
 =?us-ascii?Q?iqmVb3FCQvz0qQNIMCq7m7QjQmC2N/+PDOPcDLo0omkdtGax1Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 13:50:58.9536 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a989457-2ee1-4c91-19fe-08dcf2a08f27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9064
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

Some devices do not support fullscreen 3D.

v2: Make the check generic.

Fixes: 336568de918e ("drm/amdgpu/swsmu: default to fullscreen 3D profile for dGPUs")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Kenneth Feng <kenneth.feng@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index accc96a03bd9..8d4aee4e2287 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1236,6 +1236,14 @@ static void smu_init_xgmi_plpd_mode(struct smu_context *smu)
 	}
 }
 
+static bool smu_is_workload_profile_available(struct smu_context *smu,
+					      u32 profile)
+{
+	if (profile >= PP_SMC_POWER_PROFILE_COUNT)
+		return false;
+	return smu->workload_map && smu->workload_map[profile].valid_mapping;
+}
+
 static int smu_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -1267,7 +1275,8 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
 	smu->workload_prority[PP_SMC_POWER_PROFILE_COMPUTE] = 5;
 	smu->workload_prority[PP_SMC_POWER_PROFILE_CUSTOM] = 6;
 
-	if (smu->is_apu)
+	if (smu->is_apu ||
+	    !smu_is_workload_profile_available(smu, PP_SMC_POWER_PROFILE_FULLSCREEN3D))
 		smu->workload_mask = 1 << smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT];
 	else
 		smu->workload_mask = 1 << smu->workload_prority[PP_SMC_POWER_PROFILE_FULLSCREEN3D];
-- 
2.46.2

