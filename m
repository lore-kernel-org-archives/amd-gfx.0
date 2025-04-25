Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 592B0C369D3
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Apr 2025 18:41:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8BE310E987;
	Fri, 25 Apr 2025 18:41:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="leWtwV6A";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B78AB10E987
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Apr 2025 18:41:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JLssF12VdM6zz4xxIvhbzsMzEZl41Bk+5Lg9Oem47d62/v6t6+kf0sIfx7ubO68r+ya2tHCm8BXnOpUDJKwbxJCFYitA9NYXaXqOafqV75lVhA4IHhiEDQOZi83wgy56NY87IHBeULv6c1daomQi9fBOyTKGwUot5a858xvAGBINkeqURQbQz/nRY3R0tHyEiszdMtbuqbXYPXTZROSPujkXJKk1Dkia11f/husjqD2cmhpGdBLVfhwCEeUlRIhjr7h9U5Q4/bMb4DcyrHAqYKG63I/Wcgv7yeGaJ0+N3COeqSKSGZGqI1eW4yh+p74ko38pZjpHFpxGOqNHN+2eww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L12XYj3p9BMDF78onq6L+Ggv0MVgDlMEJuVT5/sCIME=;
 b=BSDpWUhys49peFYBOnAGp/3TV+0YSqRtnNTn9ZV/72kxmrf/RzJ64oTc5aTX9WwOVi3/m1cOF4a616ovxmwh7MDWv0Pe+Gc9aQO76MdGsrU3/m1z4zfEviJtOIzpF3SStxLlIiVNm2Fzt0RcpJxT4bY71e5OgenRUzWIAJK0FiXc5IXjv0hkNUCu6e0O4SieOsA6RdZFyAwvROcGuHlqdq2DyhN/HzIgVxsrAO//ZHztbXWhBzQLKkfApYE7nTNMVMkO4Y2vNf9QfPyc8ajemew6bjEa7CqkXNB16qn19tDKiLSpdPghFnOzImCo2u1Xr+3pO3qkewOAoa5aNX5RFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L12XYj3p9BMDF78onq6L+Ggv0MVgDlMEJuVT5/sCIME=;
 b=leWtwV6ADBoiX1UaLOpgZ8KALkBk4tDB0ckNDgw035ik/Yzd/9WCiXKHaPabDPZsqTGFdGifAyo5Adqn4aAIrE9koT/G8REN3zhYQbxXXW6ju3036dopEPhJgIY4LFeSbmQWHZkQrjL0eK5DbDXccuudoBmLZehsLSP6kuZ9Hbw=
Received: from DM6PR11CA0052.namprd11.prod.outlook.com (2603:10b6:5:14c::29)
 by CY8PR12MB7610.namprd12.prod.outlook.com (2603:10b6:930:9a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 18:41:42 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:5:14c:cafe::6) by DM6PR11CA0052.outlook.office365.com
 (2603:10b6:5:14c::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Fri,
 25 Apr 2025 18:41:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 25 Apr 2025 18:41:42 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Apr
 2025 13:41:41 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/8] drm/amdgpu/mes: add callback for gang submit
Date: Fri, 25 Apr 2025 14:41:20 -0400
Message-ID: <20250425184125.166270-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425184125.166270-1-alexander.deucher@amd.com>
References: <20250425184125.166270-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|CY8PR12MB7610:EE_
X-MS-Office365-Filtering-Correlation-Id: 16bde06c-08ef-4b18-168e-08dd8428d2cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?c88UIvDP7k+7G5nMCnIDMLzn7mg/UQkP3Zj/vNX15K8zS4wBxkj/O4bU4LNY?=
 =?us-ascii?Q?nwV1h745rmpC4kVvgOgVisbAIbkcb9usKvrH5whWYz+43VgxwSn2Bf5CmMQj?=
 =?us-ascii?Q?SfM9y/3EhXHRS+djvvfjVDshUOmMG50f5pUWHLSEKtGgsArf8V7KhCc2JpK2?=
 =?us-ascii?Q?2sx29Y0llOBeLXNb1J0haDeilxIi2e/TsbHITOJIyHM7xrKQisoGv6efuWXE?=
 =?us-ascii?Q?0MVHX41yNSzBbpeJtE0XtVLX40zOnk3DPkO+gtlTWQ6i8OT4s8elNdYCEDc4?=
 =?us-ascii?Q?8p/fQEI8rFx7QI9iq8IrAT6kVLZ773rDhLwN93bEwTqVlMXvReFi6fju2YrY?=
 =?us-ascii?Q?n63ImUunw0iHgJGRZCqXmPu0FJvfuzvV1qniPmrFrZMQf16IFefQMPNKxa0U?=
 =?us-ascii?Q?WkvOXHBvt6DLA477fyFD6WuvY4Hdl1frq92YVtYJAFFvJOApzy1D39NR/Xdt?=
 =?us-ascii?Q?1wpyPXR+yceBBEh2zWadTRYsFFSkDje5mcsqZg4O+LDrzkCBAFQ9tsD/pYrs?=
 =?us-ascii?Q?0b5sqnLwODLpm6abxCJhUISyM4zbhM3tUKgcOXDhY7Eo/ZwjQIxVb1bSo0cB?=
 =?us-ascii?Q?wWEfnB2i1gE5cC4/mBUzbykF4DSGDvoGqcOJ7K0hCXyip+4LeSICv8XFK4Xr?=
 =?us-ascii?Q?gh9SQcwL9Gi3qvZRi+0POUKrCO1gij5WxzvWGPmWazp+3BOd6sa3meCFARb3?=
 =?us-ascii?Q?qPpKyUXVCazOWW+d3fdMozfrvoJOI5y85rc1nT2l9HDEX/K/sgvQPYUbCjr6?=
 =?us-ascii?Q?M4UP4end1fOzeStm8ZPS34J4mlVZpDG6QTZxj0OL9TvS7oojqiuu5dkKE7ry?=
 =?us-ascii?Q?3LqBh/5SX/0F9EyWDHxtFNE7IvO26oWxocq8wHXWXdpjfLQPuuXlH2Znqwop?=
 =?us-ascii?Q?Tg4w1/i7M85YEQEvsMCwvttTviFiM2qXOkyXkFCOV9xJXd3aK6oiBjqX9njl?=
 =?us-ascii?Q?/0DaTPl1WQKmMLqJD9sGiXodXV/K0qlQ7LCB9ZlOUpWJYkSQP12cp+bzImDQ?=
 =?us-ascii?Q?GBGRLzHq0OkAmHNNJPtmBF/6Nrf9b3P0JrEXwW5OmPhWiJkBZUlNSLsgijHN?=
 =?us-ascii?Q?b3SN47rXcrNlc9N3JJZSqi/k8atAsAJF9MAUDuScsIqer3Yl70S6nKdQZIgT?=
 =?us-ascii?Q?y037wZeLiO7WfXJUBakjLAUYy4y69JB/+G6AQNlFt7oSR7o8esauHB6w/+h7?=
 =?us-ascii?Q?K+Rk2LAN4Iu0oZPRoYOGmT195busFFk6psojNIZOnZNKp4kB7sAytq7kCayW?=
 =?us-ascii?Q?oeHPsAMrhA2CCHI+5VHRaHzPTvvaWVmSesj5szLWiHc7Fp/a90BkrMZTAFzn?=
 =?us-ascii?Q?1YPX7YEvOyfDer7Trzz7fNH0NcItBWHo60eoebdnPu20H+4uqwIFGJUmrMjJ?=
 =?us-ascii?Q?s0GT1LoC2ozVq51+7kI2ImTbNTQ0nXDtmuOBJr9WvO/f0ClcWLBAiRXa1Vri?=
 =?us-ascii?Q?iD+qF9MnXTpX5pNdvJPvuw23JcfPV+L5qgVJO2tNhi2ilzLFjgI/SVHnEsjq?=
 =?us-ascii?Q?Mr1w/YxGN4RSl2DVTRMbUZpcC0CdFaIo+UXs?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 18:41:42.5886 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16bde06c-08ef-4b18-168e-08dd8428d2cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7610
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

Add function pointer for gang submit setup.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index e98b0d892a593..bd07b02521414 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -279,6 +279,11 @@ struct mes_reset_queue_input {
 	bool                               legacy_gfx;
 };
 
+struct mes_set_gang_submit_input {
+	uint64_t	primary_gang_context_addr;
+	uint64_t	secondary_gang_context_addr;
+};
+
 enum mes_misc_opcode {
 	MES_MISC_OP_WRITE_REG,
 	MES_MISC_OP_READ_REG,
@@ -366,6 +371,9 @@ struct amdgpu_mes_funcs {
 
 	int (*reset_hw_queue)(struct amdgpu_mes *mes,
 			      struct mes_reset_queue_input *input);
+
+	int (*set_gang_submit)(struct amdgpu_mes *mes,
+			       struct mes_set_gang_submit_input *input);
 };
 
 #define amdgpu_mes_kiq_hw_init(adev) (adev)->mes.kiq_hw_init((adev))
-- 
2.49.0

