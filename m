Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3787C04FFE
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 15:12:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31EA5112D18;
	Mon, 29 Apr 2024 15:12:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3fRyF9Q8";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 895E8112D15
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 15:12:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oR6cQDns0/v8g4ppVjH1kO9NVQiPqSTYxSlFY3EaZNGwefff/Wfs24HflXs0hJf1mtn2iz07/un3g2spJ34rv/ZTU3jMy1od2Cg367HmH2WK6XI2mQo2yNhX8ond+gr6x+jKNSQJTgsEAGtVA0+xSDPYDHhYMiUwqWOG4bvW+oagGd6vwUayJXWCIqVH0mIya0GnfmMP25gj0DRmMGBUobiIdoKwIqjGNUfW8UAtR6NHjN5fTGRgXVj86wvzRyfdPlBFy/QO/4Gtdb7CRVK317vblocVk9I1lgq4QiLptz68MoQVCNbQD+zDzq4sjo3IuXFJEePwYoEG+AedESXQag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KsyObGgnzVJPgV2hqljLO91bQZ6EFFl39ca49lVp9Cs=;
 b=MrYnz5hde/HfMxIH7cIzdMkjThGkrq31dHq8tRjhtUCLDyIDrZALczG96WKuGGkxbEV5gjRvieHZbmmgiE0aX/kZQJ+4Qf4P8GMNsJ/QJHIVhd1URp5mXvOwcxn91SWjz+TOOwyr00FiAbo8TtmQoAKTk4PAAmyO1jVDh2sDZXZDtAP5hEk52Dh0gMtvhJt/X3wOXFUyalLrdHxi0v/F8br9IRuGDwQj/pOiBZnJmo7xZ9hQe2BSqHyg/hw+cUGpm+S3mjkBpAU5AMF83Xd4sbWjmihLSagr1vRqDQF69sCNNoRjXaFIDRtIxG2m8xR4ZjRDmRfRjX9f1g8MWoidoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KsyObGgnzVJPgV2hqljLO91bQZ6EFFl39ca49lVp9Cs=;
 b=3fRyF9Q8DJYGiXuypV0EIsKzSIrp3+hNPuAFvHEts3vtgrtYYGAh6NsG1+KbGyFYAoCUc9LVy9vQP38eeUGgWmK8iGpK8OBOgp+tAsxzF7FCTDdSs2ZOlPpWdRvyOABiJD047nd7tQ5ltqCbtY+TwO/ohPqU35umFqLKf1CgX4U=
Received: from BL1PR13CA0197.namprd13.prod.outlook.com (2603:10b6:208:2be::22)
 by PH7PR12MB6441.namprd12.prod.outlook.com (2603:10b6:510:1fb::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 15:12:43 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:208:2be:cafe::31) by BL1PR13CA0197.outlook.office365.com
 (2603:10b6:208:2be::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.21 via Frontend
 Transport; Mon, 29 Apr 2024 15:12:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 15:12:42 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 10:12:39 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jack Xiao <Jack.Xiao@amd.com>, Kenneth Feng <kenneth.feng@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 09/11] drm/amdgpu/mes12: disable logging output
Date: Mon, 29 Apr 2024 11:12:17 -0400
Message-ID: <20240429151219.3466531-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429151219.3466531-1-alexander.deucher@amd.com>
References: <20240429151219.3466531-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|PH7PR12MB6441:EE_
X-MS-Office365-Filtering-Correlation-Id: ede631a1-dbb5-4231-23d7-08dc685ed170
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|82310400014|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?22JEPWxtqYtq0z7M2hMEMoMyRWNfxSjL4AyyQMQiYOYIm46ugiu1PcSBOiM2?=
 =?us-ascii?Q?RVMGYhyLbvRi8RBzoPk9IpusdY8E9YscZCHyierlat3s8ZpZ0jyHjwcVMjcV?=
 =?us-ascii?Q?f43h5IetaBQBlsMYy/zLljlj3321lRlXk9Glsh8htIHy2/OHrXuHWiPm5CY4?=
 =?us-ascii?Q?HWQvNSNkHdRMa0gbSQr9Vh1onWhTxDU2YDtHTt4ORlzky8DLYWQ6j+VL7Bt1?=
 =?us-ascii?Q?OxX33L9941zjDWJI7hvymoYCAeZJpRHoLzOMRsWoer9o5z54/g3R0siEOWQR?=
 =?us-ascii?Q?u+jesYQpMb/rIh02LuX97bZj7hTPkN2tWLEiBNtGkXCbpDWI6OdRnu25rBob?=
 =?us-ascii?Q?eqNvhsFylEjwzAplY5VCUGahF5VmQAgqcZU7O8j5LJyzRBo0b+rLJ9S04agT?=
 =?us-ascii?Q?v3eItkyHK5tfLlOhfCyYZ4Wzpo0vQDkNT1n8+cg9JJ2JMb9y+2qNUwo003h8?=
 =?us-ascii?Q?hTivN+mb/MUjJj2JbpUjNcqDwnD89yS+EnfcOo8JRjdzFbuMwDeV6sk3RdQY?=
 =?us-ascii?Q?PCdMQrPO5PsoNGjjH3rAWtH4PmxkT49SzTK2DkfkmJNnVIIFEm+vudPBmHFu?=
 =?us-ascii?Q?TLXChqKkht8G2ppmbIbN9XIb1lm9CJRBnANZjw/x39AP4SjsgKalTxKwNMa3?=
 =?us-ascii?Q?BfFTlwQCHyxvX1Wy/E+wFgp3Ol3sZaoALMI/Px1ORaUfZSX68JClNHFxTaZT?=
 =?us-ascii?Q?011CONz9auFLEDWas/qEts9FQWrfGgFj68pu/FH0FdGgJe1aLeolG2mtO51I?=
 =?us-ascii?Q?wVF6xm3IG9bXSK3vNsGBdpjM01yBx6SmWHpQvqb+quCEGzWYemfhdxIbLtFw?=
 =?us-ascii?Q?4xM6bPJtA7EHi8KQPDBes/txRkqfNAsMGsTlfsxaVS8hT6XiRhqX1TcMyZrs?=
 =?us-ascii?Q?VWClw4s5HuAOrzmrrtYZMeFC3Am9A0fj3VunIHGUInjELuK75aqD07gHZ0x6?=
 =?us-ascii?Q?uKKNOh5sr5WuFPw+sgrDYW3KHrS0OtZo2i8oR+JkBREBOMbhBDGjFCYyHE6K?=
 =?us-ascii?Q?bIOfsmXlFvaD0/6TQilWAAvrOAEhM9AeRbFiD1A37boKwzJKvetN9zedTJZs?=
 =?us-ascii?Q?mpn20mrO57Y3kw76xQhTvOWcFn/A4TFNaAdsRPPI7pSZJdd1yfGm0qHe+Iu4?=
 =?us-ascii?Q?Gcu86wAvzZG+RLfcgxKj4TveO4Yr9ZZk9vZPeWBcTbMlgl3HCG1WvtzIQH0U?=
 =?us-ascii?Q?VOv0XZKehKgeRbdXz/OguUET9JdvnFzCnDFBvBR4NR638zSP1R2AOdaehKsp?=
 =?us-ascii?Q?2UID6mkdY3e5v+e42+d+pS9LdrXNT+Eh83KNeFlLGSu/jxg8tdDJcBaS3pYH?=
 =?us-ascii?Q?UyNVMRUJNsqsm3jYUHfAzKIXgQWR+u8VGwpWtM7ggkkO/Roc/+cLZTjMBPUe?=
 =?us-ascii?Q?lHT5gI4opEP1x+fc59stjj3W7vZ1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 15:12:42.8363 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ede631a1-dbb5-4231-23d7-08dc685ed170
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6441
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

From: Jack Xiao <Jack.Xiao@amd.com>

Random page fault was oberserved, temporarily disable
mes log buffer output.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 0b67ff9c04924..cbd5b312a075b 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -440,7 +440,7 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes)
 	mes_set_hw_res_pkt.enable_reg_active_poll = 1;
 	mes_set_hw_res_pkt.oversubscription_timer = 50;
 
-	mes_set_hw_res_pkt.enable_mes_event_int_logging = 1;
+	mes_set_hw_res_pkt.enable_mes_event_int_logging = 0;
 	mes_set_hw_res_pkt.event_intr_history_gpu_mc_ptr = mes->event_log_gpu_addr;
 
 	return mes_v12_0_submit_pkt_and_poll_completion(mes,
-- 
2.44.0

