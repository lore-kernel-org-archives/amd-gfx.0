Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76DA3CCA476
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Oct 2025 13:57:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21F7510E19A;
	Tue,  7 Oct 2025 13:57:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EAZYxo2t";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011049.outbound.protection.outlook.com [52.101.62.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7491810E19A
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Oct 2025 13:57:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lIjZTZRMdpilMkulWJ8Gn2RV7OScGrgxr19S/GZCgYhXtHrR+KBS7M93ZGL6ffTNJMqLxoq0xnrrKsJWissOtkNmNOus5yGc3tecup4BqWo87Yba7msoMQua4p0IVVRxS0z6IxGfHDTAaUJXTs0ndEgn29CDCqgHTRmmaSuZzNVzLzAghugP2GuDAbmeUXYDHbabB0SENhIvqPycf2FLz6LNIa4MO+BeX3MMseZsAryej/U751vWRDNLd3dwZPbKo/N3DN4GS7ZibJU0WTNx9syLuDBXfHLIyw+/ys5DQZAKHimaFNEVAUn8saZp7eacZZpHMHTbMm/w6OYHNnV8aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+RRPfF5mMMTZxPIU442H6h8XqGJyhPXdAare0nWxEY=;
 b=wLqXcrDkXPkltdQohtcvHqxtf7ITCW1Jaw067t9ivssU7YYbJwn+41UMp+2qM3HrEBsqAHKLa6HdI+PEypDXyMhYiIUdnkt8DXsgStA0PaS0PUr3Txu0yMehMQgdtEoV/bY2pX7G9BQJXjb3VK2ESqx8bBfLiNMfne26toH2sOEvjUOVtg82GnckL//iHYCO/oFbIV1wVAv1bQv3nZKL2QBOcCDWwZ7abrgnmhaxbDYwaMGXTQv5F47RbhygbNJ808hi6lhyLbUipfx1k/gaENmDuHhWZlqmSvJmEgdwMZYWPGfjo90EVAnUxhqfn+LcOjXpZ/zkAvSDe1br/vVENg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+RRPfF5mMMTZxPIU442H6h8XqGJyhPXdAare0nWxEY=;
 b=EAZYxo2tXj4Vx/+V5MeSXdERi6k3NxF7354Qgwzn5ikZ8t2K6JZbJ+RUseuDGGEwxmNOWhIZkV2BcU6WQHW/0At2YiB9KHaahsOmiLLZkd9d0Ndri5+cY/7T7jKrOvBcwDckWjX/6AVJwrEyEJPUUtPkOMk6Xe7E5g+WxrkN3N4=
Received: from SN7P222CA0020.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::10)
 by SJ0PR12MB6781.namprd12.prod.outlook.com (2603:10b6:a03:44b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.18; Tue, 7 Oct
 2025 13:56:57 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:806:124:cafe::f) by SN7P222CA0020.outlook.office365.com
 (2603:10b6:806:124::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Tue,
 7 Oct 2025 13:56:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Tue, 7 Oct 2025 13:56:57 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 7 Oct 2025 06:56:55 -0700
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH] drm/amdgpu/jpeg: Add parse_cs for JPEG5_0_1
Date: Tue, 7 Oct 2025 19:26:23 +0530
Message-ID: <20251007135623.622247-1-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|SJ0PR12MB6781:EE_
X-MS-Office365-Filtering-Correlation-Id: 95263ec3-9ebc-472d-695a-08de05a96145
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RmI1S0ZHeVQ4MHF6anRhdnNUNHlWbTB6WExhdjNIenJZdSt5aWZIMjVlNVZk?=
 =?utf-8?B?QU8yNWR0TkFKM0xNV214MW4vZmlHMmVreXY2NnpiSW82VVpkcFNET1RaR2sz?=
 =?utf-8?B?TWg4T2JZRVAyNGZqYUF0M2dVcDBvM2k5YUdzQ05RYXl4bVdhUXQvSUU5bEcz?=
 =?utf-8?B?TURpalN4QmtzelZ6ekFoSEZZV2huQ1d6enRISW5HcU1DWFJsb0g3ZDJhVU1l?=
 =?utf-8?B?T0VHOG9nRTlLK3hCbFRIbzJaTXFVeEIwLzJ0MU1GbWdpOSsyVTJyN0RlbWo2?=
 =?utf-8?B?Kys3dkljY1hsTFZLdGpwM3crclN0VVlrSHdTcksvb0hnQnBFNDJqdFFlOXBK?=
 =?utf-8?B?Mld6RjBGdldESjVncVI3YjZQa25tbmZHWGZVWXlXN2RxQUpwbncrZlRIbFJJ?=
 =?utf-8?B?Wkl6ZEloRy95M3IrZGVkeHFoZGRMbUo4bC9ZdzZ4bGdWTzZIc0U0K05HcVls?=
 =?utf-8?B?bnNWUDBKWEdjaElDdjR0MzNYUDlTRVY3Z0VaaVlEMStGTTJzUDV2Y3BKSnJj?=
 =?utf-8?B?NndieXNLaGFkYW4rdnpSNGRpWnpUVnoveHN0MStDSmU2UFRyWGFRQzYxc2kr?=
 =?utf-8?B?eHd2RExmT0xhbWhYemNOUE5XNFgrWFdaa1hRVlJGOXc0MTdMdEZnRHNtZlVq?=
 =?utf-8?B?dFpRWjZ0QzVzdUQ3aGJnT09pTGsxdFAvRmhmbjhTaUxjajRGMGdWWmxZcEZY?=
 =?utf-8?B?TjZ0YlhlRUM1U2xwUXpKY0dPRHlpS01Na3YybHFDaWFLS1NoS1d5Y2tCdmxL?=
 =?utf-8?B?NHU2c25HWTRLUWwxdmFBMkNiV0NQNTRFOFppa1RvQkZzTFhmTUZOYU5GSkI3?=
 =?utf-8?B?MS9vaWgzdE9GMEUwRTdQOEZaekRJT1ZHMFdYTWxleHZZeXcva2RDZmpQbUtF?=
 =?utf-8?B?MXk5SU8yOFhKWEhPYzRRZ2hRQVdyZEFiTk12MmNKWWZYN0psRS91RWk5WTVq?=
 =?utf-8?B?Y0h2MGdVcWpIeFZwRkprRzlkUmZqdVpDQUFwYzVQdURSSFJ1M2l4cEpob2hX?=
 =?utf-8?B?a3VlQU5JV3dJMGk1UndUY1hRQ3FobVVpak83Y0M2aFRHakZhUjI0djJlY3NO?=
 =?utf-8?B?ZUtzZVlodldaWEpZNDBFdmtOL2liNFVyRVlWRDh2MG96MzlERDJ3L1pIZkZx?=
 =?utf-8?B?ajJzS29OcE9xcy9JUTBFMVB3ZHU0ZmlabWs1VWNWcm8wTVZydnkxK1FWMUx0?=
 =?utf-8?B?bVdYdmd3V0UxS1cxQnlRdnVxTEFVd3daaS9mRmVXQlNHWHBRL01yWm51UklY?=
 =?utf-8?B?Z3BXZkpuQXkvQ0Y2cUhqbXNrRUpnTzJ5TjZ4dU4yVzFpbGpXUlRCd0FSL0tK?=
 =?utf-8?B?RCtwQlA2M09lRThIbmlUN0JCSmozRitKS25kOG0wd2huanJZUGhLL3o4Zzl4?=
 =?utf-8?B?TXh2dW1KcGdDUmk4clNBdGJKTmlhdnErTk5CYnUwZ0V3ME1GZm9ObDdtWlZX?=
 =?utf-8?B?QzNzVElpUjBhYWx1NEU0TnYrN216eUFoSDkwd2JyNnZSN0JmYS9OV0RGSk9N?=
 =?utf-8?B?ZnhjTFk3VFlSWWJ6Z01QY01kams5U3d3QTVjL3pPeHlkTGwrVFBVckNVZURI?=
 =?utf-8?B?Z09wcnpHYUsxSnR3aDJwOEI2cXE2R0NQOFJhOTZkb2xDQTcvQjhBcllzRTR5?=
 =?utf-8?B?M3BvckdMN1p4QklJZTNZZ2Q4NDlFWTlOZm8wQUlEM1Z2Mld3QjRaU1JPM2tq?=
 =?utf-8?B?V2tNbzRYSEYxcG9HUWxrSFlua3hHZGN6VU9rQ3ZYeXZsaHM4eURxMWw5WC9i?=
 =?utf-8?B?MmcyamNIQVN0Y1MwRnhlUm1GU0JaRyt5VzV4L2ZzSm9pVmNyVG5nTzhsbzJZ?=
 =?utf-8?B?cWpPT3d0Y2dzcFVxcjRoZjIxUTI3d0o0TTFyZFlSQzR5TEdzdkVFWk50VU9l?=
 =?utf-8?B?dzJXUEdrYUFEK0w5TURkSFB5UDY3bDRHek5pWHFPcGZjbDB0VllicVlzRTAr?=
 =?utf-8?B?WGdIaE1KNEtrT3JDbmZhb3M2bGs0eit6a2pObStKOFlyKzFwdENaQ2lTVXZC?=
 =?utf-8?B?MVloalhHVzRXSHFVNm5tdVRPazIwckFwb09mT3RJR1dJTy9mVjlaaUNMTEw0?=
 =?utf-8?B?ZnlMa1VobkZGUTJYOURSRHpGSGxBYjhZMGIvM2hRZEF6MFhBRDZDUFZMSEIx?=
 =?utf-8?Q?Xb5Q=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 13:56:57.2086 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95263ec3-9ebc-472d-695a-08de05a96145
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6781
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

enable parse_cs callback for JPEG5_0_1.

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index baf097d2e1ac..ab0bf880d3d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -878,6 +878,7 @@ static const struct amdgpu_ring_funcs jpeg_v5_0_1_dec_ring_vm_funcs = {
 	.get_rptr = jpeg_v5_0_1_dec_ring_get_rptr,
 	.get_wptr = jpeg_v5_0_1_dec_ring_get_wptr,
 	.set_wptr = jpeg_v5_0_1_dec_ring_set_wptr,
+	.parse_cs = amdgpu_jpeg_dec_parse_cs,
 	.emit_frame_size =
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
-- 
2.48.1

