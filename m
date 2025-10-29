Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE4ACCD1BF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 03:11:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 298FF10E6E5;
	Wed, 29 Oct 2025 03:11:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QgW1l97+";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012038.outbound.protection.outlook.com
 [40.93.195.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A79110E6E5
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 03:11:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RHG/lKzM/nFQcoiQjBmXO1qlkBFz+2SYIdkIGAzHcGnlqxx6VUEaLGxQKc9+MdV6EbNRuSbpdHz4hJuI1oiwRyQbFXzBpudwLmEzgh4BPszWMIK7v5MQSddelb2ez4ezv7v8xjnM9eRt/D2A5AitYWPy8uxPqSRu360+/ymV49a7c5UTKXrfhL8kJ1ELQrXu1Q6C4xin1eP6PdDqZ37EwC4xQIBXMZRiCKN/BKzLGd/z9/B5qhlpGEmuTMxTr8S6/o6mbV6AdH0inDVHJiTrNINxOpiSArT3MElMB3PobzzhqoAOpC2LAITj3RNJfPvjVsVrODgIIUhLXXf2gquWeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IK0cc/MIR/2263zID3P+io7wa2NoHYi5I5GFxee8jBU=;
 b=lfOh/wdtdBwMA3xNjwfIy3DVabgGgLFyWMe4cjdYoYp3Pm9k7L6zEsUxXjJTrCvd6MgjO5q5hedx7VeCHNfkZ2NhydYWCos19nGZKSy8Tdr7e6t2xi+ne0ggAB0yUCA9XWkYtj5ooEWl5c/98dJV3U/KlTXVz3LY5Syx5FdrSoOjF03KxTWrLoPREWexkMpJh+MAI+61wWBz6zCC+Uuxq79dPzRBpcYLeLZnomtDBIdGtHM6L+lveAeIGRfsNUpXFgcbBvtuQ3MD9aHmuuxxDbeCPj/pESa6JJU/HWgUgLul2CxHJ4/Dckzs2t0oW09QbRNODndV/8VfyJ121fKs2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IK0cc/MIR/2263zID3P+io7wa2NoHYi5I5GFxee8jBU=;
 b=QgW1l97+Vg2KcRhw34Bg+Gx4qNc0K2ChNxUL6MVRtHWfwEzcuZlz7Qw/U2PxzD0Vhcvoi9nJ/s9biJ2V3b97BqTO5qmk8qPNMXgXX6u9rUb0EGqYy/6+F1IAG44dPxhNQkD4CPalj9jqFp1vqRk2S10Mhyr5eKqTvY6gxKBYZS8=
Received: from BY3PR05CA0050.namprd05.prod.outlook.com (2603:10b6:a03:39b::25)
 by BY5PR12MB4033.namprd12.prod.outlook.com (2603:10b6:a03:213::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 03:11:01 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::47) by BY3PR05CA0050.outlook.office365.com
 (2603:10b6:a03:39b::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 03:11:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 03:11:00 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 28 Oct
 2025 20:10:38 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 28 Oct
 2025 22:10:38 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 28 Oct 2025 20:10:29 -0700
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Austin Zheng <Austin.Zheng@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 03/13] drm/amd/display: Add pte_buffer_mode and
 force_one_row_for_frame in dchub reg
Date: Wed, 29 Oct 2025 11:02:51 +0800
Message-ID: <20251029030935.2785560-4-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251029030935.2785560-1-ray.wu@amd.com>
References: <20251029030935.2785560-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|BY5PR12MB4033:EE_
X-MS-Office365-Filtering-Correlation-Id: 50247b23-a47c-41fd-67b6-08de1698c9e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vQMxTX3J/iouULP2IIv6c8nGXTN+sRvSI8F0DytEVUGU84y5o4NkIs41LmBc?=
 =?us-ascii?Q?Zvm5jeUO0+ysgUTd/p2a3KVVbNu2NNWwwPdWXcC8J2N4c3mhYIwm5zE/KOWm?=
 =?us-ascii?Q?Tc77h3b/+BkEyk/aU2kt22IVYeHHEjYuKX1x269a/zU0VY2Vxh6VSUw5e9FA?=
 =?us-ascii?Q?by35EuZKJQR1yyvJpydMaCWLPbPMOQcv5u10q+tg9jnTo7baP9ld/s3L94QC?=
 =?us-ascii?Q?dxEMSeDwPw2P22tJHStBcGcLSLClAFMS25crV2r+kTgwEtcfzW5HNUgTHg1G?=
 =?us-ascii?Q?/WCGFo+ELqNrpKTYcgAO5nCXEoZE3jJ9OIPvTid6gGjjB6Vt3gWsR5+ytcmt?=
 =?us-ascii?Q?igRhqnRSiGH4xCQfmqFNpiXBtZ/mUQLaja8dCv4YR7K+hyN0R2HFXgt3TFQZ?=
 =?us-ascii?Q?8r8GRSGlxTmIJtd52ByXSQbJCfm5NFCld9CsIRMI/v6dO2lhZNfTQIclt8r1?=
 =?us-ascii?Q?fWxXqTMf4KiYta6I8HcRbe2e43FgNvlaT3GXefhiE2g7IvM27ifY4Bx/MWSP?=
 =?us-ascii?Q?gOt6Ae7jPyUi8pdvmW7dNkgzPh3VRYc+fMnpa26NwJMPH8h5ZvZJOhEtDmeq?=
 =?us-ascii?Q?ZxdewulqcFbsb6dSvmgeggFuI1r1TM+FfyVgVmJBD3CXIKKy8GRx7Fd65k28?=
 =?us-ascii?Q?a7aUMRqshXRIcdqL9z7d/naD+IJrrhXzhEeeDvh7SedNtV+Hdxo9Yg0B/GMi?=
 =?us-ascii?Q?cHdumTSYGqyVSWYnXFO1D2icpXWtGbh37vzIc5W5FBDcbb7I//WLfUrFV5uU?=
 =?us-ascii?Q?dpPUcSIbT5OsDS5GwjgTMj/41TIjYij3b6fMV/YPEJe/SV6r6JMZ2jvSg1wr?=
 =?us-ascii?Q?/t1/HtjHgVJwKekUR8OMk22sb5+VPHUslr6LlbH59qRl0NnE4WsHx2+aznTw?=
 =?us-ascii?Q?pzmkj0Gzz6uNoOlIdsBiTEp5vyCsQj+CKogIux02SOBUkDLr8zxyLxy6gDZX?=
 =?us-ascii?Q?nV648oLjvtlFjhiTM28XUqkcTXd5/FqQfL4E8wZm+f/Hogc9eSZDsCxr3dIa?=
 =?us-ascii?Q?+yEykqMVLUlYH+hwEFR9nFy1MLNG7UfGyx/kMuUJLla7Q9sbuWmzPZsQr1sE?=
 =?us-ascii?Q?3errq4Tg3f90pV32yuoHs/Bw63uQef24pN46N5ljY6gs8y9ymSMj0+Iss6uf?=
 =?us-ascii?Q?C/vVywnCyXi+NuainD4MAVBSXIXMagoiio0k6wESwXIT6SA8E7Js3WSDAZSI?=
 =?us-ascii?Q?D+LDj8a2QcpYC1BE/8UxwfsN7c6wEwI2xZS0RCT9DZAkVWO/tolrxnPMI067?=
 =?us-ascii?Q?xNNPTYWYfTXpegZdr81AexvH3A9n310UYIfeP/gku/bsgYmI4Lx9uT/+GU5q?=
 =?us-ascii?Q?qcq7KowxgloK3LhDTzugDzBM+u2pBA+8ptbX3T36nOa/dRKnwdFSNOI+mh5F?=
 =?us-ascii?Q?D63zMKfjofgq22LAlksauQtlb1tXA8Mc3k/84NoNHp2zzWPeEEyGIXkXop4b?=
 =?us-ascii?Q?6mNJtKa6zoQim+bpzBvJvqqqfbovf+CsmHflJo8DoiVbxYhlH4jtvt7S69XM?=
 =?us-ascii?Q?2/geOoDkT4OiQV3Q0jr+t9nX7lWn8bfIjJ1GjXx75ctBHx9TvuNTYgWI3nvp?=
 =?us-ascii?Q?xUSuuzT3uJJD8PFv2TE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 03:11:00.9905 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50247b23-a47c-41fd-67b6-08de1698c9e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4033
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

From: Austin Zheng <Austin.Zheng@amd.com>

[Why & How]
Update structs for rq regs

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../amd/display/dc/dml2_0/dml21/inc/dml_top_dchub_registers.h   | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_dchub_registers.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_dchub_registers.h
index 8e5a30287220..bf57df42d1d9 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_dchub_registers.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_dchub_registers.h
@@ -121,6 +121,8 @@ struct dml2_display_rq_regs {
 	uint32_t crq_expansion_mode;
 	uint32_t plane1_base_address;
 	uint32_t unbounded_request_enabled;
+	bool pte_buffer_mode;
+	bool force_one_row_for_frame;
 
 	// MRQ
 	uint32_t mrq_expansion_mode;
-- 
2.43.0

