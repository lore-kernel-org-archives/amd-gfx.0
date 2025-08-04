Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9417C87FCB
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 08:41:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44F7B10E4E7;
	Mon,  4 Aug 2025 08:41:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b2uoedCo";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B5F410E4E4
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 08:41:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=px/2c6+vL8ugKsWNZZkcXuHxvKRBFrf3muSlt/OnMVE/SYwvIQb7hn2XGSRAYRYG61cYxUO+Ovvm9eTnc3YUlS4B7gel+WPtgmFZTdTFVi8xl0oJj69bcMLZV5Jo6LdpS+We/GSFNuPMpNkbl5Xuufnrfz3CPEjL5YD0Q2a3K4n17ruYHYq3Dk9axCc4NqwxNjLwR+xugEfqixDrUwt3tTVadZB20zvIVqBb1Y11TlzgTLVrPjqIUvKDkB/25466egtduYDS021eYeuL1fNY7wffG1H2rI6l6MNRMfE95plkHue1B080oMOCnFSpZVDv05KQ60g8pmg7ZWe4hPLHrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Igr3rqX2xKf3SuTBHw51r089BGfR0OGsesa+8cDDvt0=;
 b=KZ7T5O5+eEZ4wO+OlG3JUAuRX1c7EBK71CPU6DAfdiMmrpthSiQ97suCQAJ7FU1fknz1zv2C577mGuTLSvaihIt38QCQ+K85IcB5t+tZnHZ4txTF6DbF69tmk18dxx3cDTJgeOA0uMWU9oBWQILwVqE9YxK/Unh/CGXm3xdG0UHgM57Kz8cFjog9cq+OnBdx1PFzEoz5yvTZZXDO312QZHggkgOPMYKsTxrQ6wwrWDcHQF1Y/4m7VRdxlr7X36rqwslQynWVTNhXzF18UuYGdYxZdBdJA7KFQN3aXcbVjmJ6qbWkaEmL9I2wXUCPtX+DL81U++WfBMLexEc1IFBFUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Igr3rqX2xKf3SuTBHw51r089BGfR0OGsesa+8cDDvt0=;
 b=b2uoedCoiGT+S3OVK8vn75T2QDZcqYvC8cKoaH9bYGwmzVc2l0awC5pX8eqZfKSL35LgV9JgoVrr3l6FsWbYerQhGTCig8fAoZjutEyi2bHhL7NdkvK1TfzmtLqhwA24U78xRbezfje1ZQwgrekXEHdjuDxtv/uveKxC0mXxVRU=
Received: from MN0P221CA0005.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::15)
 by DS0PR12MB8342.namprd12.prod.outlook.com (2603:10b6:8:f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 08:41:17 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:52a:cafe::c9) by MN0P221CA0005.outlook.office365.com
 (2603:10b6:208:52a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Mon,
 4 Aug 2025 08:41:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Mon, 4 Aug 2025 08:41:16 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Aug
 2025 03:41:16 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Aug
 2025 03:41:15 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 4 Aug 2025 03:41:14 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>
Subject: [v6 09/13] drm/amd/amdgpu: Implement MES suspend/resume gang
 functionality for v12
Date: Mon, 4 Aug 2025 16:38:27 +0800
Message-ID: <20250804084029.863138-9-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250804084029.863138-1-Jesse.Zhang@amd.com>
References: <20250804084029.863138-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|DS0PR12MB8342:EE_
X-MS-Office365-Filtering-Correlation-Id: f77ac5b1-5ae3-433f-d22b-08ddd332ad6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?N8mL2Y6DA5DuiQIHn2/LOD3QICv1BWArf8Q8s1IQPdy9M9v+mbgn24K/FAss?=
 =?us-ascii?Q?xUt6Pz4TTM7mE8pLtjCeEpUvvsDj/djI+GHY3+uZRMlp66pZOZB26WzbnDvp?=
 =?us-ascii?Q?Du5fGGkbEZzhc6oWrYPi5iZqFKNM8Uu0S2a/vdQZqegUykL57DcFhbXYwSkm?=
 =?us-ascii?Q?0fO5xRTGiMssjaTmXksJe9fAhxlg4dLXj7sSHU9eTHTrYLgV2ysprGwT/tKZ?=
 =?us-ascii?Q?nVkXUOI0QGe0pv1Ed6ufe1C26SADFmlH11C0+TJbsxf9lEuzDvL/G57YAwwG?=
 =?us-ascii?Q?Wu5szc5cJK6aGMHTVox+0QNLVfRuj4RyWWstoJMfRN5NMOmyMveuUEm/cGO5?=
 =?us-ascii?Q?BOF19ksbe7jfdo+/gWrqdGjjnrCFTqozmF0dTC8/unkREqyKNEZC7qJdIRdr?=
 =?us-ascii?Q?BiYAKs/X+ZbyzV82ZozztugSlZMOdmFQNkovK9hdDE3YAon03uvM61P3+Hhe?=
 =?us-ascii?Q?MxHWTPKEpKhr7oKzO50cYAorVZw7b1p/a611+rxuzrTDBy7TkONCVEZCSCjl?=
 =?us-ascii?Q?n6AgEYQTdXLz6hlzqfOEl2T6lEOFOiMjiP3pxOMkkO1g1dqsCCoRpwvP6LdF?=
 =?us-ascii?Q?+O3r6S+4CeokfoujEvfCKvXinMSmDcgmDr2dj0X5fFoPOIHE9v+ZWTNEFwX9?=
 =?us-ascii?Q?G3yLLZaMj563HE/o0qDZlnpuvuAd08ZP5z3mjfInBiPyfyzDuuHtwGf46gTB?=
 =?us-ascii?Q?P1fLAX/fxT0A8uzPUbF7LCMlWzlxrzgvzW+y8SDjbfelbNPX8dR3mD+cBswr?=
 =?us-ascii?Q?kXw64Duowubx5oIF8gJRNC15LsETxkSsbZjoQUJbbwofci4wSaVc/qOse63J?=
 =?us-ascii?Q?z14GX/vO5fnuiQraZLMDI66y207aISwU7lW4uEL5f1StsV34bs+8tBv1UybC?=
 =?us-ascii?Q?lRbVElFqQMc2SFS/kj/RW22DkW7Sc8nbuv2h+0Ymp6W4FNe5alPytymTns+K?=
 =?us-ascii?Q?5MCXZbH15hSavVz6fgRZfwLFO7wUo9f9dItuYhRNDHFWVDXN7yqO+NvdLEu8?=
 =?us-ascii?Q?OkJTF404J/nYPqctOpFfsXbzdBQY090XE4HxUGPfRjivrwvXQza3SdO+0Ukr?=
 =?us-ascii?Q?SbG84X/qi8K9Z8hULbYqnzdBB8aTc8gm5T0NHCskXR+/BwFzFg43e7gxMw8+?=
 =?us-ascii?Q?f0GerpvmyB0Up6WFh5EV6iRONao7EOLYUVJ1M0ipPJPVMGav+pfybyAzfpSb?=
 =?us-ascii?Q?LzFtxMlpHWbL9R+BqLJHWNOWxGTX5w9qb4peaEkosYD5RiQfVeNQnbXlgF+y?=
 =?us-ascii?Q?bM17r4qdnxJ1lKYO17oEzA1qICygUwnfQLZEXobYhDo6kGokGyu7mFVHuMsR?=
 =?us-ascii?Q?wwsC+FKksOnNAxyBSzIX8yr9TBVgfQTN/dZw8dgnzienTT6tgNtaxiZ78yQ3?=
 =?us-ascii?Q?aiwzLNd+P3KVnGTZPzkIeeb34mWQcVFlbz+KC8wLHF0TUmDupLZouTRz6gIF?=
 =?us-ascii?Q?TV7XQ3FB19Vv/KkpBp0p0Q0AqtnNIIma98hT8lyexbXI5qANFu7ZWv3fh6ja?=
 =?us-ascii?Q?V1f+wY+aiyvgjyiiFiFFP9f+WHPYQ70qmV7X?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 08:41:16.7495 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f77ac5b1-5ae3-433f-d22b-08ddd332ad6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8342
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

This commit implements the actual MES (Micro Engine Scheduler) suspend
and resume gang operations for version 12 hardware. Previously these
functions were just stubs returning success.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 44 ++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 579720695e9e..9c86dfdef1bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -569,13 +569,53 @@ static int mes_v12_0_unmap_legacy_queue(struct amdgpu_mes *mes,
 static int mes_v12_0_suspend_gang(struct amdgpu_mes *mes,
 				  struct mes_suspend_gang_input *input)
 {
-	return 0;
+	union MESAPI__SUSPEND mes_suspend_gang_pkt;
+	int pipe;
+
+	memset(&mes_suspend_gang_pkt, 0, sizeof(mes_suspend_gang_pkt));
+
+	mes_suspend_gang_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_suspend_gang_pkt.header.opcode = MES_SCH_API_SUSPEND;
+	mes_suspend_gang_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	mes_suspend_gang_pkt.suspend_all_gangs = input->suspend_all_gangs;
+	mes_suspend_gang_pkt.gang_context_addr = input->gang_context_addr;
+	mes_suspend_gang_pkt.suspend_fence_addr = input->suspend_fence_addr;
+	mes_suspend_gang_pkt.suspend_fence_value = input->suspend_fence_value;
+
+	if (mes->adev->enable_uni_mes)
+		pipe = AMDGPU_MES_KIQ_PIPE;
+	else
+		pipe = AMDGPU_MES_SCHED_PIPE;
+
+	return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
+			&mes_suspend_gang_pkt, sizeof(mes_suspend_gang_pkt),
+			offsetof(union MESAPI__SUSPEND, api_status));
 }
 
 static int mes_v12_0_resume_gang(struct amdgpu_mes *mes,
 				 struct mes_resume_gang_input *input)
 {
-	return 0;
+	union MESAPI__RESUME mes_resume_gang_pkt;
+	int pipe;
+
+	memset(&mes_resume_gang_pkt, 0, sizeof(mes_resume_gang_pkt));
+
+	mes_resume_gang_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_resume_gang_pkt.header.opcode = MES_SCH_API_RESUME;
+	mes_resume_gang_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	mes_resume_gang_pkt.resume_all_gangs = input->resume_all_gangs;
+	mes_resume_gang_pkt.gang_context_addr = input->gang_context_addr;
+
+	if (mes->adev->enable_uni_mes)
+		pipe = AMDGPU_MES_KIQ_PIPE;
+	else
+		pipe = AMDGPU_MES_SCHED_PIPE;
+
+	return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
+			&mes_resume_gang_pkt, sizeof(mes_resume_gang_pkt),
+			offsetof(union MESAPI__RESUME, api_status));
 }
 
 static int mes_v12_0_query_sched_status(struct amdgpu_mes *mes, int pipe)
-- 
2.49.0

