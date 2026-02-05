Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0083AE9126C
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 06:51:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A76210E7CB;
	Thu,  5 Feb 2026 06:51:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r1RDIZc4";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012053.outbound.protection.outlook.com [40.107.209.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66F6D10E7C7
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 06:51:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DYvQdrUdm963HHqtQokgnxIZnKoKyTy8P5LjWODNdppIGByMPxXXf8FXIldtPUB+Wusl3Xw4mL9E6V0ZoTn7GWkV0eoCBIiXlktrsoKcSYsb+ZwcQPcy/2bqqcGhhFteNj4gk0mef86dJuVZMZwfInToGPgB0wTtNisiSlSjJcViR9DJUpwF1y55qHTfIoPCYFMrZPu30TIVlYUW3cY8xCIPIcTwe+dSAYpXqgaDlWuH+ZcX1RF/eX90BZrAdlzuL+VfrNV9p0N6MIjCi8NpRA3mEXXGBiAwt7F28L3owjBPrRdVh5bIeyrdsAo1MEEXgMcViNrVjOn/yza1d+4wig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GdiaP9ulJMQWKNCxLkm5y0sm76GH5vvV3aJRI8ZdUZI=;
 b=GEaZK0nn3a9hlQbx3ecSx0GjuSQSVnNJaCoX4yrlBTrytSrxMI6gZHtIaM8HJGRbaCwQH+anqhd/HqkeRj9yMkOL/Jfhn+1lHIPKxf/bSIIAjpL3PG0T2cdmY+2VOgT7SceLDR3kHbj2tMOrJUv3ntsoVq6XMmrHXuDPL6mVygngsFViwA8IBMW/EqoVeRJIy4EeEjs72bAMIZbWh4g2KpxnvTQx7GLv8crDCSCiZww5ENXc8fxF+ryPCCsarAf9ZH4RAloR/xRubNBs3xSPuYC1WlStAIxflDAkPGIU6mv3Q3izSoyqGv7V/AW6FRaojR3I/nT2cO+DoE0yRShWwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GdiaP9ulJMQWKNCxLkm5y0sm76GH5vvV3aJRI8ZdUZI=;
 b=r1RDIZc49T9+7UQBwqJCRqSLHb4YiUvwwaFAJ1XoDlmrQmK4lCEp3qP1MolPJL7R9PDWrurOtoOuB4Cl94ulrt8pBppR3GMPVDnd845m2TXVJFvB9Y97U8bwzLrOwst5sdtjNie2BjF3CAHvzxxR9b95N6+4tIDbjPXJuvGYJzw=
Received: from CY5P221CA0044.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:4::10) by
 SA3PR12MB7782.namprd12.prod.outlook.com (2603:10b6:806:31c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Thu, 5 Feb
 2026 06:51:53 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:930:4:cafe::89) by CY5P221CA0044.outlook.office365.com
 (2603:10b6:930:4::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.14 via Frontend Transport; Thu,
 5 Feb 2026 06:51:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 06:51:52 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 5 Feb 2026 00:51:50 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <alexander.deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <yifan1.zhang@amd.com>, <perry.yuan@amd.com>
Subject: [PATCH 09/22] drm/amdgpu: add firmware version check for PTL support
Date: Thu, 5 Feb 2026 14:51:17 +0800
Message-ID: <20260205065130.654921-9-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260205065130.654921-1-perry.yuan@amd.com>
References: <20260205065130.654921-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|SA3PR12MB7782:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e3cb47b-eb36-4779-851c-08de64830b4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vguELIWaf609v7P85TyBzYnCfLYSD5c1MXDWyhz4F1HWJESuY/IMRnnpU5Dp?=
 =?us-ascii?Q?06xMOyrKIWpFoVFIHQW/g/gorKaX8lgiBu3px0vqNQqD5fu1xfX7YxhtiCTq?=
 =?us-ascii?Q?3w82LCiVCh3ZwFYufFb4LB07YmCyf6LoSItIbgu6jquG0ZH9oC7KeoFMF2Jz?=
 =?us-ascii?Q?4a+nug0m9wFwfofxzawDQZo+Ntb1EnCqyliVTI9HSWJ4S1FPpacHfqdpA2oJ?=
 =?us-ascii?Q?fgLlgrw9NOJDsc3h1JqQJIYXP6lzipNtyusTH8XGMS05POvkx0hP5dbA7kEq?=
 =?us-ascii?Q?MVNfhE2WF6PN9FanuVlPoNO9yV4PB1uefNRrRskd9FgFGysgZHZOzD06NB2Z?=
 =?us-ascii?Q?x2IIWCWwYKxRqCcRN7TXJi3+PlNPce1XvHQ3xauTKXfUAQGMVxNbrHmEZzcG?=
 =?us-ascii?Q?LkeSMznqTPsu67rF9ROjqlxW+9EzhuA/iUodRsJtKb5q2wp+DmZLUA0Gd6w6?=
 =?us-ascii?Q?ViiUWzTWDeJhYpMMx4ZvfJSjuDbIIVH9wqvAUkWPYlwgj6RoZhf808CWiMR6?=
 =?us-ascii?Q?0VjzUfwsaADzlHo79OCgHtBEbW9FT9NcR1ZlsDHTTlfnO8YqyfDMHAR0YdTt?=
 =?us-ascii?Q?9BX/Iqfi+hJmLgqOAhn1fN5vlSHMoP1K2sFcUq44Y2AShFe4WE4PaEEhq/gt?=
 =?us-ascii?Q?ddSE/uJ2Ya1aF3tifMn49woo8uOg4Opqke2DWmWcsZCaDvv3f/KylTdNxBMO?=
 =?us-ascii?Q?IBudfpD3HrFjxPB/xaXVTGwBjVn/JK2S7twsI9gkCEYNZwROuXFYtmQxArUC?=
 =?us-ascii?Q?uJ96DjXubt28pGmZKBrmLtYXyYl5tS34tQjzulxFyQ4+Q1M8NbVFUKy4Bg3A?=
 =?us-ascii?Q?BAOnKIUq8WMVXits2h/KkmPI5u8guu7Gy8X4E3G6c1MQCjcEaPdtExM4RjfG?=
 =?us-ascii?Q?gRy59654s0ki1CGbekNl6nI9p9YZ1EA7fkmfAgFnREGVJm/h/m55ViS9x4Ol?=
 =?us-ascii?Q?y09XHdNI7DC2hzaHyuXlDEIIpsuCvH74ste8THRoxtVpacbt+TIPD806auTd?=
 =?us-ascii?Q?cTnY+HP1m2oC68ZnIBG/vZ65ZE2wCrb3LKudx55eTWbOY0bwtI6+34f83QHq?=
 =?us-ascii?Q?UEL0FilIKSwfK66JqWiBM6Nt4RND6UXneS1+rHfaqdFs0f8wI/TVvrN3Ivoa?=
 =?us-ascii?Q?vAFdterMFz4zXzMpfqHz+e5TVwUZ87WJaQQaFSywYJBnFWk6DUMWyFNr3+B0?=
 =?us-ascii?Q?uSzY8WtsAqzkn6fQqEJx5CxSE3EJNWOHLVJwjb3zLvXs4KyVe9kvIt91TztS?=
 =?us-ascii?Q?Ufx1dOETqI4ONbYDXgr5Zf85O4Tmj8kg/Ak+YYcypRFPN1XI30IJ53MzTlnj?=
 =?us-ascii?Q?an6jB+hTrcj8Fx6onmJLAan+E4cMD/AQ2PxZi5UyFJsuZbe0xn4+xyUd0y7y?=
 =?us-ascii?Q?9tXGn5oTF0wWKZVuOuMJNs3xrB22CzuTDC6bhmjEZoWKCiJPQbB6jMgib9qh?=
 =?us-ascii?Q?KN2y3IOGlZr1ZIjS0QdTYSNv0Etzp/1HpD4cLEus+G59NR1vo3vf1mFC6DIB?=
 =?us-ascii?Q?0iM+Ti0B78tLzauKp6vyS4SD3OuYkdvAagvMGIaH4X8dSPKJcgfMNC0OVr2Q?=
 =?us-ascii?Q?QNx7web6t5VmjD3S0db6NAotG1C+OBPmxGkCFB0ExvZ3+ckRAu0fR5sZQ6BT?=
 =?us-ascii?Q?B/61dLaBOE9elJotlbaqJiy7rIQUa6jIxd23c6nP/1C7XQabU3hTQWYYadNz?=
 =?us-ascii?Q?wL9/Ug=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dkZvo6oXtgfNpcDNJYrkjIxYiJGCkx0bL4bo2MEBkoz+ZPRT83gLMqS2gYcA0mvCiyu81Q3NPtGDym0k/xS/9gvslqiQ5rYqw7bjMvN8TRkbWwJHHuYRxZ3hUgkBB/mOTyTrLolP+ob1WuQWjUrjnBnyYyaT0Jcl5crfIgq5EvNjBzAXH1xYrfxdT3d3zdUXVfmFVoa7lqWJVe1sAz5JCi9TV324b+4NYYVw6QGhcvCybOrOXKDRbk+oh4zJ4h5Inu44oiHkRuF44x59odryDGujFkQpzcbSMY1R+eAMASzsRvJOdA2Kr3H5GTVD9OhzYS4dHsqu2NS+sFZqhoc0iovQoKZKeBqsYmT3CtwBlgiI4TbsNZIVRYY+xJS8odqpvxrsQLTUa25/5vgKzL/orZU9IWkxDl6N7pBYBMqf0WnA8/P4OhBnxLKnznuS0czU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 06:51:52.5687 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e3cb47b-eb36-4779-851c-08de64830b4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7782
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

PTL (Peak TOPS Limiter) functionality is only available starting
from firmware 0x0036081a.  Add the same firmware version gate in both
places that already verify PTL hardware capability:

v2 change:
* move psp and gc version check into psp_performance_monitor_hw()

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 3 ---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 9cb30f3e21be..a5f101ef51ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1252,6 +1252,10 @@ int psp_performance_monitor_hw(struct psp_context *psp, u32 req_code,
 	if (amdgpu_sriov_vf(psp->adev))
 		return 0;
 
+	if (amdgpu_ip_version(psp->adev, GC_HWIP, 0) != IP_VERSION(9, 4, 4) ||
+			psp->sos.fw_version < 0x0036081a)
+		return -EOPNOTSUPP;
+
 	if (psp_ptl_fmt_verify(psp, *fmt1, &ptl_fmt1) ||
 			psp_ptl_fmt_verify(psp, *fmt2, &ptl_fmt2))
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index a970913ec66c..d94bf21db281 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2376,9 +2376,6 @@ static int gfx_v9_4_3_perf_monitor_ptl_init(struct amdgpu_device *adev, bool sta
 	uint32_t ptl_state = state ? 1 : 0;
 	int r;
 
-	if (amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(9, 4, 4))
-		return -ENOTSUPP;
-
 	if (!adev->psp.funcs)
 		return -EOPNOTSUPP;
 
-- 
2.34.1

