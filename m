Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 524C8C369DC
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Apr 2025 21:40:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9DA910E2EC;
	Tue, 29 Apr 2025 21:40:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r36ZF3Au";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0024810E2EC
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 21:40:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F8BaKdowSkJNjIyv0OKEUljdXLM7Fyv7Ywum4PC7rTRD7zApZZ6YM7vGmSxP4FFE0jmDWRQsk7d5JzRTUPob7gImGP7ow/nrf54HOcYhkxdqNaZHuCegEcMIPFU91RuqyQY4syykJ5cyG/mQlMSqzW0IwqvX05F+CTya1IdHzYfdXgIQi0zmBVS/MFNYdynT5K+KuYoNmNPfPshfDsMajHN149adHqAjOlycP2E4+M/m5hwbss9PVg6nCoPwXkGii0p+vX6v43ftVE/dYicLKAGKuVnGeFBXsOj59HPzhnYuCkekLtmC89yqxfh6Zbwwz0p1aj+pbQaQBqVc4nIyfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+rVLP0d/brmhGujJcm0SZbx0oGG1Jxn8AP7iYdTIkU=;
 b=yrWTbjNPsAuIrJLhkvA2DwcyHbDrMDpaV5CI8hGi7wKXkFRZu+UK8SkvnP6/t/ABiFi/71Db8iWkQYctxGHk85iqfQW02UDY0vI3JDHb5m9AhwP43p4lVJjrSsDUY046ZGvpK8uNoIvc2/4fLytovsTj+s4ik9TnE3NvQ0KiHy+stsRTv2GhLCKVsAjW0YvTbeT1HT1X87R2vvYZrj9UDLV8Qv+kcGA7sPuvAgmRht7ti0+iRSWmGzRnzQq/99UXVidCZY5ZjRVifV4df/Z8q0HtOf1feuHHV9lwh83s6Lb5y/7B82BYK7QeJqviS7Tim9uRBZC2mE1OXOOiQZ1IZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+rVLP0d/brmhGujJcm0SZbx0oGG1Jxn8AP7iYdTIkU=;
 b=r36ZF3AuZjWtK6rCYH4ok3/wNMN0c4Pu0IPUkxMpMgIvJ7A/P5agnrwv4inkWoEg+y/l/t0bOSMZUttatx7vMnjRj3eGhZYpMteqhWDAdjxv95jKNLxqsuqHCdv6olETzLZ03jn434AL+gJcuZkFRoh62BI9Dol2EFrdSND/YDs=
Received: from SN6PR2101CA0018.namprd21.prod.outlook.com
 (2603:10b6:805:106::28) by IA0PR12MB7722.namprd12.prod.outlook.com
 (2603:10b6:208:432::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 29 Apr
 2025 21:40:52 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:805:106:cafe::e) by SN6PR2101CA0018.outlook.office365.com
 (2603:10b6:805:106::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.13 via Frontend Transport; Tue,
 29 Apr 2025 21:40:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Tue, 29 Apr 2025 21:40:51 +0000
Received: from asrock-1e715-b03-3.mkm.dcgpu (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Apr 2025 16:40:51 -0500
From: Ellen Pan <yunru.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Victor.Skvortsov@amd.com>, <Ahmad.Rehman@amd.com>,
 <Jeffrey.Chan@amd.com>, <Shravankumar.Gande@amd.com>, <Zhigang.Luo@amd.com>,
 Ellen Pan <yunru.pan@amd.com>, Victor Skvortsov <victor.skvortsov@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: Add unrecoverable error message definitions
 for VFs
Date: Tue, 29 Apr 2025 17:40:41 -0400
Message-ID: <20250429214041.93096-1-yunru.pan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|IA0PR12MB7722:EE_
X-MS-Office365-Filtering-Correlation-Id: fadd5f4d-f90d-4a13-803e-08dd87668391
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nOcWmI93Syup4jZAeGr+YzAb78K8aucYEPPE19kk5mAsl5viCBD+EX0aQ/8U?=
 =?us-ascii?Q?3GGS77p5xzScz8SAYF/DoquFSKQBZ99EYPV/WcqndcK/B+08cKwL9D/Z6KL0?=
 =?us-ascii?Q?xwIkfl/LwodMaDSDlQbsBIuzfY0LwZGqqKNiAZZzegk7GAFCvYHoVD0LBFCy?=
 =?us-ascii?Q?U93DWX7feTv6bU0qxjxsjmEsNG6lHDKzkT1bEMqOuUaL+XJTnirWnPg6Anep?=
 =?us-ascii?Q?G4tNg2HDwM11Vk0x/dTQexupjmCvAjswqdYLMmXTYN8DvStN+/vmHKnTNBKj?=
 =?us-ascii?Q?YJ3ViTdmlmKCR164z3piQMpmhf6znl07rPtHdvIF6ykIAxAAiy6WCLVex/Rj?=
 =?us-ascii?Q?VgG/+TuyaKgInG0xetOlnREtt3Qx+XJ87URRHjAA7PZm14iviYFhz28EjISb?=
 =?us-ascii?Q?GI81zuypnscsuFzJeBLVWgLWVfbCcrNVbjxiQheZ2UCxsXojFx6C0WTctZVB?=
 =?us-ascii?Q?XO0exgFjO/Ld+EMBmRfExsS/QmoH0E1MuIsAU+d+qEvoX9Wj4cTZtEZvDv/e?=
 =?us-ascii?Q?mAzByzMO+1XqBjFW767w1zJGVvF2a9dSrKsR1CuZQ3MxoXGVqgs0Hg1DdDhV?=
 =?us-ascii?Q?P+9NmYpvk1e9+/YAYWzQkSbfDofh7h0bVcXO0rtNdDBCEWtrKGhYChTxMRf8?=
 =?us-ascii?Q?wwTFozzDP3eeToYiwVonW5G5BmnccjzzoAcoaxoNO4Gt/NxDN0EC/6usM7UB?=
 =?us-ascii?Q?J9asgfZ2j+FDzitTo1DSgGEOMxV8LlPfgtdduLCKp/r+ViUCmslb8Nih8x2r?=
 =?us-ascii?Q?UNi6nUnQTJXd135xVygAWVkq/d9qA/YFXndl0v7MfU0R+3RrUDwkUsOA2wgX?=
 =?us-ascii?Q?Pr1nFu6beFJrpGi6fSF9L1CCfDJeF7OgD0m7OX5F5qTBBLD+C6e+Ldpi7wRt?=
 =?us-ascii?Q?wNZfyi7oPEDeF5/6dETI8RuQkuTxDl+OrZgKLBZKYBM02+5kgD5osf6whqVg?=
 =?us-ascii?Q?WF2HXsMsxRdNJD3UtvJFU6WC/8KNCE5b9blL9G90EfaD7wMvGWbKIc5bYCRI?=
 =?us-ascii?Q?0DBlzYjooA4Ci394FoEvj8dH4tjMsYZOYWZ6pvuNghUbyC4+ZYhVc9Lqt4g0?=
 =?us-ascii?Q?JokW7AQFMrHtWxRy314e8cyIA4wTWnBrYrEwzo8nsqOorkANoWwTPVSAJZGn?=
 =?us-ascii?Q?2rZ6FpKyRa2aQdlCXS8s+KSBrjZ3w/aaoqXA9ExQezunc+txvYqP2Wbo3LDQ?=
 =?us-ascii?Q?yU5MdfhAn4BkjuAGj35R7X6irWv/NUi7cZNChN8sizmdbS9CL9sVn5M/pyo9?=
 =?us-ascii?Q?psfqiBntv9fPKFNO1U6WgY4c/+kk5ahJaRR40tChrNGoib5A2z2BQ1F2/J0d?=
 =?us-ascii?Q?YIVwn0vHjhTXmVHWYBSDht4muYzA9LHpVfbiNw6CZpOMu0UhA2/lrFxjKfkb?=
 =?us-ascii?Q?M1cBPTir7gj6bNFy9g41lwnXOtMRsgKkQyJvNs0hZ/9ZAz2XfMU/KmCS1ZPG?=
 =?us-ascii?Q?YryTqg1/4HT25BSnI7VrJGC395zUYO5v0W40vBGlp9Z/NJKSQhiSNgytMaOV?=
 =?us-ascii?Q?rrJf7yFgN+/aKJb5gxIcVtDz5MpN/yIi+VMR?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 21:40:51.9593 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fadd5f4d-f90d-4a13-803e-08dd87668391
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7722
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

Host may stop runtime services after reaching a bad page threshold.

This notification will indicate to the VF that it no longer has
access to the GPU.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
Signed-off-by: Ellen Pan <yunru.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
index 3b0c55f67fe4..92ca13097aaa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -351,6 +351,7 @@ enum amd_sriov_mailbox_response_message {
 	MB_REQ_RAS_CPER_DUMP_READY		= 14,
 	MB_RES_MSG_RAS_BAD_PAGES_READY		= 15,
 	MB_RES_MSG_RAS_BAD_PAGES_NOTIFICATION	= 16,
+	MB_RES_MSG_UNRECOV_ERR_NOTIFICATION	= 17,
 	MB_RES_MSG_TEXT_MESSAGE			= 255
 };
 
-- 
2.34.1

