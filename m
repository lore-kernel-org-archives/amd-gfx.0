Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CB4DC61CE8
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Jun 2025 14:48:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 094D710E87A;
	Thu, 12 Jun 2025 14:48:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kzXgNeJo";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9065D10E0B7
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Jun 2025 14:48:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JZqCEsSmhBpe6pUQXi/q5VAJ6G5LelhetLETvgUX4OL2sbQpz3Qit+MIgfwxZYYaFGO7Xe4fATVf8UPZfimxUaCDB1P4n/hd59mGRScJk7MUS2S7wqPT3n6uDkVtRIk5q2jP+Ttn8UpJatV/IrX+jbLR7HnzP6PbEBzQWgyAfIBSCN5QZq69ddnEsEHyLep1YkQbpYZExIXFZQjkWvN6B+qFvSHomy/2khPYIsuKzqxhII+EmZ8e1K/YaQSh0ur9KC3x5EZtK92lfSUp4BAVBhyOexmGa15a1Q7uqyaQT1Cp4zWUaBzyz06L/PS9rhAAJYsySZ/VSHA14DTqWJlfsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZWElI1wUVAd0nktp6GtfTRUdcwRrrJIQ0i7MuZzyzUs=;
 b=aLZOU5/Rwdw1d9uXqhDtlr6s6A9reUdm810e3vtMbvW1qr49kfXIMdodbdPIS1ScRiiSMuHYKbNr6J4R+LtMyDtF93y6fVOGX+qg6YsCGCUmtT9Ihu4oMgb1XifxZFEhFzC4DqiYip/+iUw56ItTyMsc8qaMCa5gYIxsicbeps8l2rOugtYBLhbYdr8BRh1e42W3hDeDBuTTwXDe3gMbuzoS4GGMtMmNAlxYzyE+BWkP4WQDXYOB1DSQj5H3sx9CTKSWE5W+QKfb0mP9sWthhjQ5GPc+TOHot5FAJEd7jZclL0OV4oOtM/nZpVf0Yfp7zkqTULHAJvSr61eSB8sL/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWElI1wUVAd0nktp6GtfTRUdcwRrrJIQ0i7MuZzyzUs=;
 b=kzXgNeJoZGL85pB4fbqJKCePtjoQ9gB7GKNBFSDHl6i0RcHGuPhXl3jMGSEPN6iVtsug94tmQfwa56cGAnLGiH2CWON0siKjWQTXqjKqGOvlSgxEcvg02z6RFbuxLsba00jGXrgKaKtalHqLk+0ZSEAaC3SWunPawyDcQ/zZ/XM=
Received: from BY5PR16CA0031.namprd16.prod.outlook.com (2603:10b6:a03:1a0::44)
 by CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 12 Jun
 2025 14:48:08 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::e1) by BY5PR16CA0031.outlook.office365.com
 (2603:10b6:a03:1a0::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.19 via Frontend Transport; Thu,
 12 Jun 2025 14:48:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Thu, 12 Jun 2025 14:48:07 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Jun 2025 09:48:04 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Manu Rastogi <manu.rastogi@amd.com>
Subject: [PATCH] drm/amdgpu/gfx9: Add Cleaner Shader Support for GFX9.x GPUs
Date: Thu, 12 Jun 2025 20:17:51 +0530
Message-ID: <20250612144751.104030-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|CH2PR12MB4198:EE_
X-MS-Office365-Filtering-Correlation-Id: 4580fa4f-e8b0-4b65-ae07-08dda9c02526
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b0RaZWNBdVpNYjg5bHlOOUM0VG1GbnFPekR1REdscEhkdTcvMUNtK1FXMmtw?=
 =?utf-8?B?dkJHb1lNVmh4WDdxaXJmcEJxclh5NklSLzBQYk8vdnNjQktOcitLN2YwNnBH?=
 =?utf-8?B?VmlveDhob0JCN3B1WFg5NGJrTWlsWGpMbXE4VTZwYlVRNVR2L1loQ0MrbG12?=
 =?utf-8?B?UkpjcUVma1lvT1AwUlRpZmhIVTB6WkJLNzhFTUhyQS9OeERwdVYycFdMRExp?=
 =?utf-8?B?Q2pLZk5QQUdtRDZ5cWZqd2xYQjNtUjBkVmNhUkExalcwZ2prS0NVQlRpQTZk?=
 =?utf-8?B?MlFQZDdjb2gxZWd4ekNmRUE0Tnd0RS81NmlsckJIc3djZ0NwU05aOVNVeFht?=
 =?utf-8?B?U09NRTYvZUZFWWVIRWFQdC9Hc1NXNHQ3Mm9pRkZYQnBjZ2wzM0UveU5ZZE1H?=
 =?utf-8?B?dW5sd3k5QlBPeUJzWUtqZDZ3VjU2c00yV08yd3FOdGw1UTZ3QjJoTUE3ZUZY?=
 =?utf-8?B?MVFTVWdoRnRySDJId05jTGVxMzVxaHV2MjVGQVUySTdncGxvN2ppRzdRdERi?=
 =?utf-8?B?L08zMXg4cjJYSWFuaElXTC9OaDNHSFJldkJYYzNYZ1EwdkRTbGNFckVrQ2Z2?=
 =?utf-8?B?bEVJbDVWWm9jU0xvbTdaaGZwdXo1enZzWHhId1g2OU5pcmFXOWpoMDhGcTJY?=
 =?utf-8?B?b0R1eTNZZHV2Uy9MZkdZT1g4K3NuRDVTYzF5cklyd1VPYmhsOGNXd2FzQit1?=
 =?utf-8?B?NmFpNGQ1ZzJKZFlVN2x1QkRRcnBNT1pGZXNPNHVObUN6cUtRc2Z4WkhDV0p3?=
 =?utf-8?B?ZTRnTUdHM1JtYVRJNVU4Q1FIeEgvOWlSRVdCSENiNTNRQjNNakRLb2IvZE1F?=
 =?utf-8?B?QTZPN0s1eVhBOCs0dThNM1ZGUUhjSmkwSU1FN2d3K0EvYmFpY3VmS1RGV1pB?=
 =?utf-8?B?eHQ5U215YUZDQjg4emc3azZxcFIzVCtHekJ3cjJ2VUkzYmZsa0M0UXdiaHdJ?=
 =?utf-8?B?SnBBNzdmZUNWOC81NWJCbUJOTEJTSDBwZWRFN1FIbzFwTmJ4djk2QjlIU3R5?=
 =?utf-8?B?Rk1kbTRnY3QyRnViaTVXZktZY0I0UHlsdFpNWWpYc3dYam11NlJRekZ6Uk92?=
 =?utf-8?B?UGRsaUIxaEZlNmFSTzBYcVhxZFdBdUhsZldRbXFwT0haU2tSRkZCSURXaFFH?=
 =?utf-8?B?QmdVNUJPQm4rbXg2MG1hcktuQ1YyYmZodWFmMzVpTHMzZzh3SHdvRW9LUnhL?=
 =?utf-8?B?NUdXUGVuT212MjN2bTRhMjV6bVRRd0VZekhJM0VENG01dVRnYTRCRXZLQ3Zr?=
 =?utf-8?B?QTNiNzhCRW1ycmw4RzBzcmZrZnlEaDhubEtKQnk2bWdBZGMyNEZLZCtaWFFU?=
 =?utf-8?B?T3FkQ1Z5dXZqOEpldzFNM29BekZQUWplN0lmMVpKbE96dWJyY1NVNHluZWdy?=
 =?utf-8?B?alk0OFRsV09FOWNzWm5OQnFmUk1ab3JoQUJOSWtyaTFBcWV6S3YzZ044ODky?=
 =?utf-8?B?TDBXNG1qMXpXVnMzMy9iMkI4NWRidzZaT2tkYjF2OHBtSDBBZ0FYSEQvYkxS?=
 =?utf-8?B?QUpwRmoxMkhYa2VQZFJnNEFWTTQrR2MrQXB2Ulp1U3JUczZDTjkwanJkTll4?=
 =?utf-8?B?T01Ba05GeDJDNHBEaDBrMitsRXNsd0JNaTRrbXVJYUd3ci9IVnRJaGZtc3Q5?=
 =?utf-8?B?YmM3MEZqbGtwT0laek9WZVh2Zmh1aEpnZVRudnNMMWpYbjhPOVlUMUkxclc3?=
 =?utf-8?B?OVlMbERBcjExaWN4WDBDZzk3TW5LYk8yekpBMzA4YWUxb01nNEpaTGZ5bk9U?=
 =?utf-8?B?NWxRQ25sYjdCV0RUeElDS2k4cTRwaG04SmpnMy8zRHd0dEx6d08zVDRMSWIy?=
 =?utf-8?B?MXBqSnN3Q1p5VDF4Y2QxVk4rbC8rOWF6S1JZV1kxcnJuaWxZaXc3UFN4ZmY0?=
 =?utf-8?B?WWVVNG56RG5QMFBVOFgyWThVcEh1bmZFdWpGRlJHQXpkS29hOERWcnJGLzM3?=
 =?utf-8?B?SlNTQUNhdy9BNlhXZ1phaVVYOUs4ZGpYOG5pdzR0WHk2MFJrY0FtVTZtRzJ4?=
 =?utf-8?B?aG1iWFBTeEw1NzV6QWJwdXZmdkJJQm43d2dqakw1SGJ4V0k3bjEwVXZDVXZi?=
 =?utf-8?Q?FxSkMG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 14:48:07.7318 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4580fa4f-e8b0-4b65-ae07-08dda9c02526
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4198
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

Enable the cleaner shader for other GFX9.x series of GPUs to provide
data isolation between GPU workloads. The cleaner shader is responsible
for clearing the Local Data Store (LDS), Vector General Purpose
Registers (VGPRs), and Scalar General Purpose Registers (SGPRs), which
helps prevent data leakage and ensures accurate computation results.

This update extends cleaner shader support to GFX10.3.x GPUs, previously
available for GFX9.4.2. It enhances security by clearing GPU memory
between processes and maintains a consistent GPU state across KGD and
KFD workloads.

Cc: Manu Rastogi <manu.rastogi@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index d50e125fd3e0..866e39f6fab3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2235,6 +2235,25 @@ static int gfx_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 	}
 
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	case IP_VERSION(9, 0, 1):
+	case IP_VERSION(9, 2, 1):
+	case IP_VERSION(9, 4, 0):
+	case IP_VERSION(9, 2, 2):
+	case IP_VERSION(9, 1, 0):
+	case IP_VERSION(9, 3, 0):
+		adev->gfx.cleaner_shader_ptr = gfx_9_4_2_cleaner_shader_hex;
+		adev->gfx.cleaner_shader_size = sizeof(gfx_9_4_2_cleaner_shader_hex);
+		if (adev->gfx.me_fw_version  >= 167 &&
+		    adev->gfx.pfp_fw_version >= 196 &&
+		    adev->gfx.mec_fw_version >= 474) {
+			adev->gfx.enable_cleaner_shader = true;
+			r = amdgpu_gfx_cleaner_shader_sw_init(adev, adev->gfx.cleaner_shader_size);
+			if (r) {
+				adev->gfx.enable_cleaner_shader = false;
+				dev_err(adev->dev, "Failed to initialize cleaner shader\n");
+			}
+		}
+		break;
 	case IP_VERSION(9, 4, 2):
 		adev->gfx.cleaner_shader_ptr = gfx_9_4_2_cleaner_shader_hex;
 		adev->gfx.cleaner_shader_size = sizeof(gfx_9_4_2_cleaner_shader_hex);
-- 
2.34.1

