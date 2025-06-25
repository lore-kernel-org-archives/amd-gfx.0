Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F51C77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 21:07:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9013010E814;
	Wed, 25 Jun 2025 21:07:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eej+nnaM";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67F0A10E803
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 21:07:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B+wX6QNFx8ZtGJcc/ddIWhs1YatkcWXyDT042cVktv05o2jlxI9sO9kxg+jtVdk70ZgEd6m8uWzKbqdoPsd+UnDlq9D9wcNTD6cLSkHt36Sdfxi+mTmO3BpGkyLUZxV8Cexk+20xyIff8EvzS8WuRLLEwPGjFH2oBB/n1DOcLDv5ZJkdXkB/YuvRQEjDo0Nm6HDwV8YXM9REgo2DHE3ewN3KuBQNZ3nZeA/jHWgDm2OhytJvHfsNVPCP7t0saZw5EfZHLsYelL5bXey1s8oPXQ1vuvvE6hk0pChEBUXwtxXms61Dcme9MAdsTF6lGtilYKgnMdasWMWs6ss/wXDUAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fJQr3O1XrRhTErH+ycjps79272+j6UfM33GnB1s4WEk=;
 b=r15+aM2yPLWhw/MXfUVhrt79uIYOiCguMWRXtN6b/TtM+WEiBPMw8vM0+y98Gpd5h/YS0lFWund1nrxQl0n7EuzDsr+IkXH06gOIf0OX5WVd0Vp+mMiK+RTF2dAgCG0KduytvZz0mMMuJQ5t1iYPyueX8TgGwwqDmDVttyvSxJhfz/ol2ieW3dVzX0vBTG0dPF2NVHQj8WBcBALP4dejKbPnPjJevtLxQd46zFunIycdKoyRv7RJHtvJKjBo4Lcv+5Nmq/TRdz0/Pc+H8WHjsOL+m2/X0duR9ejZVP0dgfeg53kI/4KNKGkYdvSoyXQuwPO2NWoyhr1W70GcgaP74g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJQr3O1XrRhTErH+ycjps79272+j6UfM33GnB1s4WEk=;
 b=eej+nnaMASEDOAD9ATtX6uL9wuk73GZy7ThRQC4V2OV+32espDp2QiMtEyCdSExS18FCJRWglt5+N2sGknDev/uRxgZBV+NOg/7MK2BX5mmQZ6z6NGD2l4WOiUC61c1hDq2a+NvQRFyV20AbJe9ef6krLmoGBxWdqmUbJwuaXxw=
Received: from BYAPR01CA0029.prod.exchangelabs.com (2603:10b6:a02:80::42) by
 BY5PR12MB4148.namprd12.prod.outlook.com (2603:10b6:a03:208::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Wed, 25 Jun
 2025 21:07:12 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:a02:80:cafe::2) by BYAPR01CA0029.outlook.office365.com
 (2603:10b6:a02:80::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Wed,
 25 Jun 2025 21:07:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 21:07:12 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Jun
 2025 16:07:10 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 28/30] drm/amdgpu/vcn2: implement ring reset
Date: Wed, 25 Jun 2025 17:06:36 -0400
Message-ID: <20250625210638.422479-29-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250625210638.422479-1-alexander.deucher@amd.com>
References: <20250625210638.422479-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|BY5PR12MB4148:EE_
X-MS-Office365-Filtering-Correlation-Id: 40c79053-5696-4afa-863f-08ddb42c412c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TaMhPw2TATU94SbNdysHRlEL9C2gWS/i8FncOc36K+EMfeATU4aLZfQvSowY?=
 =?us-ascii?Q?aGMf0J+Px36bwSjPJpqD8oy1jRCOCa5TwFXxcDdANgbrFuRFyF1UNR4arovX?=
 =?us-ascii?Q?Arg0MKl+TTGeIQXJO7SsHg/md7EXyivQ5yAWoab/6kEsWPDZ6ePyWmQWSPkl?=
 =?us-ascii?Q?PbPlKQdmun4MTxuL3SHFQQ6+KZ3Sz1UJNFBxt4x4ycLiaS1VTS6HhIwaZ6U7?=
 =?us-ascii?Q?blWvIt9F25I6sa10if1zejYMBkND2hw49fWWgAsTX59K4an76tsTyqzztWSq?=
 =?us-ascii?Q?wCxOqrUXFTdAsCA1X2gcvzhRx/F7DvJwbOJTkfLElrCOeVSSSda5GGU6phz4?=
 =?us-ascii?Q?iTTru93R21WAY64WQJmi1zAcm8h4K7TqsqLcdUsEEyVxABb5HHsifV0aPhpg?=
 =?us-ascii?Q?LIH8i4SQEp82yi6c2owZU27Zu4FDKMWG3R/HBHC3PFPYU9r+t7XIXyyClq8N?=
 =?us-ascii?Q?lsH/LjNANPdsgYJeXBHeeKqy8e2FRQhcuHRs/4mVpbNj6e5UqJryUAbz2aGF?=
 =?us-ascii?Q?SExBCQ+9q863euuYmki+6oymwMEIHWNmmUPTR5wZ75pgXjqdsrx92xcDPkkC?=
 =?us-ascii?Q?+EpCcu2j5QH7tuDETux/HvkyjBKwc2dQ95YSYHLPCpiMsFG5hplJK+OdaHZ8?=
 =?us-ascii?Q?iPS40JYzVSqWktYqDeRAcvwnl3KHW/8QBn1fc8NOBmIDRpzhG0MR8Kvz5xBq?=
 =?us-ascii?Q?Nq47T4Bmd+8OHf7AQED+Tsy8xgCucK3z3S0jjtiizmkLNbdKP2jID3tf/1Im?=
 =?us-ascii?Q?xZqb10BNtzPK6frjFJ9E6J38oCIgaUTxUsdVu/nLhcObONlh8IAxKrebcwQv?=
 =?us-ascii?Q?WTCly+IAlSryCD1yT6hPsAvpMVl0wJQhSistWXwfNM+Ve9NTEbyWpOn36TeQ?=
 =?us-ascii?Q?6325k56iTzM6zs+78m/mDyJ75QFRmw2kgrPnLHzVYQWgI0nLSJmWLWuNlnh6?=
 =?us-ascii?Q?g9qqe9/dAh3uvNwbO123X84XDwzuh0CnJVgtLoivcJK8V8H99Po9jWpm4HkH?=
 =?us-ascii?Q?GY5hFa770eSKHObY9dp1Jo4K32qhEQcvO998G23jNEWC5WMS5cyW8D5KKOBu?=
 =?us-ascii?Q?cuym9lHYOKD9A7NsUliA1XrilGQSToUmVmuOjOkYNnYbh4+oOc3rvsnDYmNY?=
 =?us-ascii?Q?OqT3ARo0BGcKjGxW1orfn/6Te52IYkzOB+woJY705xHe+hsTL1+YmiKh3ONp?=
 =?us-ascii?Q?vbHM0vRkl1SGVkDFgV0u1wfwzXP+NFSqYtWxW0R+LaQGsl7ttembJT3ZZ0ia?=
 =?us-ascii?Q?cx9FLCxgFfTiC0H9sFCFgJwiR/J1/No0foqYaU0nivZyc/d0cUP+WPssDA6R?=
 =?us-ascii?Q?qsx2TpIh78mhNItTCJXsncWDNPuSnEiKGyVNOD8f+U+4lPSmqHOYeqXZgFXO?=
 =?us-ascii?Q?pg/5d74Cx5GK42hniyWKwUOdDi4zOwjbQO8Nowd/NafxcfK3pPNpG4Xtc6pr?=
 =?us-ascii?Q?7184SvigmUpX4oc/RSAGSHEeHQVvE1JUwblMMARhKifrrLwl+x4DxntAhKhu?=
 =?us-ascii?Q?dtURPuc/D+nNnTK9/4Q5rRA8t5BVamh3gF7C?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 21:07:12.0127 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c79053-5696-4afa-863f-08ddb42c412c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4148
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

Use the new helpers to handle engine resets for VCN.

Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Tested-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 148b651be7ca7..33d210a61483f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -98,6 +98,8 @@ static int vcn_v2_0_set_pg_state(struct amdgpu_vcn_inst *vinst,
 static int vcn_v2_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
 				   struct dpg_pause_state *new_state);
 static int vcn_v2_0_start_sriov(struct amdgpu_device *adev);
+static int vcn_v2_0_reset(struct amdgpu_vcn_inst *vinst);
+
 /**
  * vcn_v2_0_early_init - set function pointers and load microcode
  *
@@ -213,6 +215,7 @@ static int vcn_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
 	}
 
 	adev->vcn.inst[0].pause_dpg_mode = vcn_v2_0_pause_dpg_mode;
+	adev->vcn.inst[0].reset = vcn_v2_0_reset;
 
 	r = amdgpu_virt_alloc_mm_table(adev);
 	if (r)
@@ -1355,6 +1358,13 @@ static int vcn_v2_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
 	return 0;
 }
 
+static int vcn_v2_0_reset(struct amdgpu_vcn_inst *vinst)
+{
+	vcn_v2_0_stop(vinst);
+	vcn_v2_0_start(vinst);
+	return 0;
+}
+
 static bool vcn_v2_0_is_idle(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -2176,6 +2186,7 @@ static const struct amdgpu_ring_funcs vcn_v2_0_dec_ring_vm_funcs = {
 	.emit_wreg = vcn_v2_0_dec_ring_emit_wreg,
 	.emit_reg_wait = vcn_v2_0_dec_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = amdgpu_vcn_ring_reset,
 };
 
 static const struct amdgpu_ring_funcs vcn_v2_0_enc_ring_vm_funcs = {
@@ -2205,6 +2216,7 @@ static const struct amdgpu_ring_funcs vcn_v2_0_enc_ring_vm_funcs = {
 	.emit_wreg = vcn_v2_0_enc_ring_emit_wreg,
 	.emit_reg_wait = vcn_v2_0_enc_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = amdgpu_vcn_ring_reset,
 };
 
 static void vcn_v2_0_set_dec_ring_funcs(struct amdgpu_device *adev)
-- 
2.50.0

