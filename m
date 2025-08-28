Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B77C8303F
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 09:22:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B15A810E953;
	Thu, 28 Aug 2025 09:22:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FrEPaCCU";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B30810E953
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 09:22:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TYDOKThyXVFxr8RGcXP05o4m2G7sPFFuefIEwnUa27I+u504K5hPD6NNPkp6CR7ALw3YGWfDvgNLNE6fF1p0yoWqsBcWlYAhYgqYB5iVzfyepEmk4nF6eKTBla7vgkG0GZQdCsKDp8gy0ymR+WcI5fxUtUPDvDARKpwJ5XBR/IA21WjR7twbzxGE7+NG1emrRMkuGEDsh67YKqvHYiVGjNAyHWF9vnZL01pIigxe4wrxHA7BIqyJ65UcLrhwJkCuLtQ4bB/FcKDa9bYsfxQlNY2k94Q6kBX6iq8s9uGYRXG7nF4Kcmvs7Wep+fWCrBbhY/sbmY6JWS/zsY/oFw9NZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nGYlBhcFsIPeTEtvMhQcBjnoBR+5GP1Av64ziVrRl7s=;
 b=v86X6Tdj+EtQncA51n2X6im9nKZWyXU+haTYcagw4St4cTYu5sH3z4eSrzNUhXe6D8Rfz9rwRD//93NuT66qLpKREJgMIC2CXm/p5dhM/ovCopcQcNYc9rxMDiIyl9LXGFSCoyOb7Y8x7aF8hJ1jF0UHbrOlJFIoFvD2Uf73JIlRb/BxdYgniE4UXBBIvNSaT1BCQlWUtz6undhhrEt5kYqkQlN04WDfOM66S2XuWcKPqmjktFyvlVcNdQetyKvrc59XvVU3FHkwR6TQIoX20DNB1vctYRHUg8/HcoQb87uf+HwzbqPEYVrnOSEx7jFp2gDA9SH+wfBwwtxCmcBTeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGYlBhcFsIPeTEtvMhQcBjnoBR+5GP1Av64ziVrRl7s=;
 b=FrEPaCCUkJIEdIowCvCputgNevUA9cltnl7aARPQDcF2bYnZoGMUZ5/m03iRVJzHYRB1Lg2WRO8LsXw2Kdh0Nrz2UgEgxKpu2XflP+b85bPsATGd2qTAsQYWhTXARGgofWowMnjcjwGC1MMcrtD5LxfOfV1oTHu27qT0GBe3CUU=
Received: from MN0P221CA0029.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::20)
 by MW4PR12MB7192.namprd12.prod.outlook.com (2603:10b6:303:22a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Thu, 28 Aug
 2025 09:22:34 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:208:52a:cafe::f9) by MN0P221CA0029.outlook.office365.com
 (2603:10b6:208:52a::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.19 via Frontend Transport; Thu,
 28 Aug 2025 09:22:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Thu, 28 Aug 2025 09:22:33 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Aug
 2025 03:45:38 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 28 Aug
 2025 01:45:37 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 28 Aug 2025 03:45:31 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [v12 06/11] drm/amdgpu/mes12: implement detect and reset callback
Date: Thu, 28 Aug 2025 16:42:12 +0800
Message-ID: <20250828084457.1999535-6-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250828084457.1999535-1-Jesse.Zhang@amd.com>
References: <20250828084457.1999535-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|MW4PR12MB7192:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b4e0d13-ecd6-46a8-ccea-08dde6146bac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lZnmnaU3LgwB5C0jkCgem8R6SCAFIgksoI4P7hgvdrxpxAfnE3P4twDcqbhF?=
 =?us-ascii?Q?az8/MDA/yscpRcEnV0FceN3Id3DuGjoZOTTTamQZ6DZS0WGuFHE3Xhu4R5N1?=
 =?us-ascii?Q?WZD7ATxMDl1VUXbaGeAjXe2DkBfFV6+g+H2WzSE3kfGws2MNwyO694/NUs7/?=
 =?us-ascii?Q?1x+douBIo6BmVjuNg3C+QQiupmlES881T0J8dE+o+OOjachqN1DFdgnfczx6?=
 =?us-ascii?Q?saK07BXG4jpicROD8+hENTC2XLE/23fyvp92gh7QnxSaIOp8p47wosaeUinv?=
 =?us-ascii?Q?VIh0WDi1Me0IY1YVRtxFgcFgjRbO+JknF9WQqIrE2pyn/TciHwfluq4e28NL?=
 =?us-ascii?Q?FdOjyIfpdFMoKeCR/1PaP5Mas+fSbuNfdmBdeQXdZ5IG7COfXhf+HH8R+zZO?=
 =?us-ascii?Q?r1u1vr9xIeXOBBSUNgmaqJ8qz636K9xSQ42CG8Z5eIU0b2ufVyNjCZK0WAnW?=
 =?us-ascii?Q?mszRa8jd+IaJ3Qdqh3F05OQ6EiLm5GXQV56KHpvlW0J+ziSjRnQXwRcIk/WU?=
 =?us-ascii?Q?pGnvKZ/9VKhkY+YUUDuLZLW1INP9YN7d92PcUff34RAoE/GsxBB9IYg9e4xM?=
 =?us-ascii?Q?AVlSupcLMA7z2VzyV5K5Y5sWO5CnxYie9O55yiKcFKDfs355rF9C6er3rlhd?=
 =?us-ascii?Q?lkygQveLh0YAtQIi+oQe3S1pVuiRlcTZiKA7ZkYO+dcNsiSkSVJg8jCAq3AY?=
 =?us-ascii?Q?LBk53O0cn3opILHWakFo7KYZ5AJuE8nkv2Gh0SQyrG4ocY9GFw/auHUZxvE4?=
 =?us-ascii?Q?NTTz6CGT2EZJFKHkJ/GCTFZQ/t9qhXOgC/HoCJxtjnYQk1TDChi4cK34Be/A?=
 =?us-ascii?Q?62Ms3WezUNdcTbUoMtrOARUw+No5+rQBDb30bh1f2ysVAGeterhQ16MMQGDX?=
 =?us-ascii?Q?wDDjUoT3uBrT/5M87Kg8BhwWNFYL+MDfwoxto3eqrY9EPVZ3GstRK3+ODU5O?=
 =?us-ascii?Q?UCfXDhJ/Wra3lq/SUX1TAqFc6kKNoZ9r1HhiPjw2dTZ8TLsBxDzpYWxpdUEl?=
 =?us-ascii?Q?ak2lWokuSwVhZP36HDWuk6ZP/9Itc3pK3divNYDEry1OkXaCvGyYtcCWdxML?=
 =?us-ascii?Q?MwOpcM8ybrwihqE3+bf1k5/428u+juIpCxfpHlyOoOe4HD6cfRCLUMx04ADm?=
 =?us-ascii?Q?QwYIX7WxXTUomMkSuM5JQ5zPCeqXFMhIaxMMxFUTJeVwn+P2DRxFecpg77a3?=
 =?us-ascii?Q?bgKVPxtsFEAk5Z2Zy9bbUtLaNOvOh/vgOgZxZOUiaCg/BidvcFlJEldF4Uzz?=
 =?us-ascii?Q?aTu22QY/tiiKutyOMHhSxiMn0PjYEjaS60vCIcESyvhTSZHXklBz2oiWeIsP?=
 =?us-ascii?Q?jR/phJDpKzPzGY4aNRoEqYM6D4+quTX34kLzeplwijMpvsXRjV45kPGL2vgV?=
 =?us-ascii?Q?rHBiIkL+I2Z31FkHnA5U64SClQOhtJTmqlZbwF0UgsJha58z6x7JWxUxHJhQ?=
 =?us-ascii?Q?L64cm10Eo+wPN72L6aOKQz5Ec5BxvdIkRh1rrqvneWBQJRRmtAWGEe6Izldv?=
 =?us-ascii?Q?OPJS5DrAdKB/mMlNFaM+AVCUk9UyuIBmv2jo?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 09:22:33.6273 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b4e0d13-ecd6-46a8-ccea-08dde6146bac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7192
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

Implement support for the hung queue detect and reset
functionality.

v2: Always use AMDGPU_MES_SCHED_PIPE

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 31 ++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 24c61239b25d..ca06046c5d68 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -47,6 +47,8 @@ static int mes_v12_0_kiq_hw_fini(struct amdgpu_device *adev);
 
 #define MES_EOP_SIZE   2048
 
+#define MES12_HUNG_DB_OFFSET_ARRAY_SIZE 4
+
 static void mes_v12_0_ring_set_wptr(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -907,6 +909,32 @@ static int mes_v12_0_reset_hw_queue(struct amdgpu_mes *mes,
 			offsetof(union MESAPI__RESET, api_status));
 }
 
+static int mes_v12_0_detect_and_reset_hung_queues(struct amdgpu_mes *mes,
+						  struct mes_detect_and_reset_queue_input *input)
+{
+	union MESAPI__RESET mes_reset_queue_pkt;
+
+	memset(&mes_reset_queue_pkt, 0, sizeof(mes_reset_queue_pkt));
+
+	mes_reset_queue_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_reset_queue_pkt.header.opcode = MES_SCH_API_RESET;
+	mes_reset_queue_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	mes_reset_queue_pkt.queue_type =
+		convert_to_mes_queue_type(input->queue_type);
+	mes_reset_queue_pkt.doorbell_offset_addr =
+		mes->hung_queue_db_array_gpu_addr;
+
+	if (input->detect_only)
+		mes_reset_queue_pkt.hang_detect_only = 1;
+	else
+		mes_reset_queue_pkt.hang_detect_then_reset = 1;
+
+	return mes_v12_0_submit_pkt_and_poll_completion(mes, AMDGPU_MES_SCHED_PIPE,
+			&mes_reset_queue_pkt, sizeof(mes_reset_queue_pkt),
+			offsetof(union MESAPI__RESET, api_status));
+}
+
 static const struct amdgpu_mes_funcs mes_v12_0_funcs = {
 	.add_hw_queue = mes_v12_0_add_hw_queue,
 	.remove_hw_queue = mes_v12_0_remove_hw_queue,
@@ -916,6 +944,7 @@ static const struct amdgpu_mes_funcs mes_v12_0_funcs = {
 	.resume_gang = mes_v12_0_resume_gang,
 	.misc_op = mes_v12_0_misc_op,
 	.reset_hw_queue = mes_v12_0_reset_hw_queue,
+	.detect_and_reset_hung_queues = mes_v12_0_detect_and_reset_hung_queues,
 };
 
 static int mes_v12_0_allocate_ucode_buffer(struct amdgpu_device *adev,
@@ -1821,6 +1850,8 @@ static int mes_v12_0_early_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int pipe, r;
 
+	adev->mes.hung_queue_db_array_size =
+		MES12_HUNG_DB_OFFSET_ARRAY_SIZE;
 	for (pipe = 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
 		r = amdgpu_mes_init_microcode(adev, pipe);
 		if (r)
-- 
2.49.0

