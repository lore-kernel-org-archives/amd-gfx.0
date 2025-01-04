Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E43CE77188
	for <amd-gfx@archiver.kernel.org>; Sat,  4 Jan 2025 08:41:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1F4D10E2BF;
	Sat,  4 Jan 2025 08:41:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0bSOYXf4";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45D2D10E2BF
 for <amd-gfx@lists.freedesktop.org>; Sat,  4 Jan 2025 08:41:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=js3YdHQLbfxcpXIBlW2JGIUy4P+0AAB8Il778eWioIN2fzZ1sw64gE3CKLgNQOd/9UD6h+Ri+jAfmiYDHMhJXOP2YQ8M8La0wZqQn5AyNi+7iSSaECVVR+d1OLDTpUcZKcREMu6NVylA0IU/E6gm62ovN/HBFJ6zqsY+fDzvkJccWL+mYIEvuHPaK8cNaxqtNRfz2lKPHXgrehgk7bc+hRgCQZcQ8mP388NBcOEP1yMuplVFVx9hPJJ0fT5h8dDudZtQdlFi4QzdXmEWCvVjUB4LeGBbzAQPWf7rxJsUfsjtVBTI7TqMlDTl9obcYqawltDzaFKDlEICKrveDlBT6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tkPmOajfsjoLa017tlHjhL6aKOHTzBu2lCyHj6eEYrM=;
 b=Yvg5k4wCpDst+3NR3tBDWbiARNci4gu8KCQLNeQjZMRiRCYAAEaOSMIKn1UD08s1kvKa+36TLMjL16GDybqeIQQ5opA7PaUNrb/a2OfuY8ixu6y2J1Jczkc6oeAeKDsvBIAByQbUuxa38LXSP1AeZEyy8EQEvi5DNQ981bTq+NpKEm7tIpkX6ixF9kCBB04i6MtmZrdVHEidkRU2udzow0uTQV2tRnlTaWSqH2WVyPvmJDd/1OW7OOgO7gMJ440Tit5M4C+Ld0yNu69YSAVXl9Zqx/TVS3Hp8w72cxBMwXJ8ZthfncsExdHv8vlkPgZF1HIT1iiUenIBXJqaEBT+OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tkPmOajfsjoLa017tlHjhL6aKOHTzBu2lCyHj6eEYrM=;
 b=0bSOYXf43R+X1zF2ipdjf9lo17kPxVa8y3YKAtQyHTfTBsV+wrppNs2n4urKF41GUnrunzjESoBGdb+eIhO8Uvm/SLuXCM5auKCPW+ZXzLQzgfAKhWCSfMwk2QzzaqnmIO0YxVSrjv/q8FdOUms2hSdNQDdUKhGV4ch63wJY/5A=
Received: from BYAPR21CA0011.namprd21.prod.outlook.com (2603:10b6:a03:114::21)
 by BL1PR12MB5730.namprd12.prod.outlook.com (2603:10b6:208:385::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.15; Sat, 4 Jan
 2025 08:40:59 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:a03:114:cafe::d0) by BYAPR21CA0011.outlook.office365.com
 (2603:10b6:a03:114::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.7 via Frontend Transport; Sat, 4
 Jan 2025 08:40:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Sat, 4 Jan 2025 08:40:58 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 4 Jan 2025 02:40:56 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v2] drm/amdgpu/gfx10: Enable cleaner shader for
 GFX10.3.2/10.3.4/10.3.5 GPUs
Date: Sat, 4 Jan 2025 14:10:47 +0530
Message-ID: <20250104084047.3669928-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|BL1PR12MB5730:EE_
X-MS-Office365-Filtering-Correlation-Id: c59a5261-a1a7-42f7-9b16-08dd2c9b82ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WEVqZG5mV1VSMWRoL056UTVXeGFyWWxLTWt5eTZlV2hhTkJqOUtWV2ZDcWpp?=
 =?utf-8?B?dCtRTFhDRGlGQWZJMTFPWjVCTmQxSUhkcHBiVlI4UklIdnRhUWcxYTJVVXFI?=
 =?utf-8?B?ampUdHorbjFya295WEphdi96b202eE9BbjVjOHpjNElKV2c2RU1nT3B3T1ZB?=
 =?utf-8?B?d2xpYWpOYS8zTlVmVXZyZDNMS3gvVmxnaFFaVEZUNGMraGR5V1FhdG8xRGdT?=
 =?utf-8?B?eUEvRVJmUGYzckdsNWhTODBMRTJuU3lQcDJHVCtja0dob3RJQzQxYmdpWXFa?=
 =?utf-8?B?SDdOUlIwWkd2eWNqWWRMSStpeE5ndFNOTVpPL0hxbDhJQm9yOUZjcXoxenlF?=
 =?utf-8?B?dlUvekhhVWJtMkw2ZTlzK2dvak9NRm40SExOdmd4WElyc0NWTTdwc2lmQk40?=
 =?utf-8?B?alllNUR6RFlVUGc0RVhHN2NyV1RqV3QvWUlVejVLSGdsVEJQZVhMdHZ5QUNS?=
 =?utf-8?B?SEt0MUdYZFJuUGI5d3hHYkdDdjM3TS9GYm14amJZZWx0Y2ZWWk5DOWEzbTZx?=
 =?utf-8?B?MDJIYVRBTTFnMWZPSENNckZHYzl5ckdQR0hWclQ2YzF3SytET1JnYnJrM2VJ?=
 =?utf-8?B?Q1ZhVzMvOFJLVmh3Nk1ENzJmM2Iwa2ZrSXdaQ2lySFhRT3R0Q2UzNlp4MWw1?=
 =?utf-8?B?RjNWSHJmcDZiOEFMUzdrWXpHOEdOdjI0SXA2aXI0ejJETnMxaXFJU0VEeTgr?=
 =?utf-8?B?dEJQNmNsblhveWZaZ3FuajUxalgxV1NOc2RLemhibmc3OVBNQVRMMVdKei9w?=
 =?utf-8?B?VmdlVkd6d2cwdGZmaFBLZFcxNGFHUjZhb202WXBiNDY4VDBZQVdPYzJjN2Zu?=
 =?utf-8?B?allXTVRwWTVkUVVFU1lJc01Hc0E0cDR6bnFJd1V4RHk1aDdqQjRBYjZ6b2lw?=
 =?utf-8?B?ZEtHM1NOVU9ZcTJXWWRXYUhyQTB1ajY1cHJmUkN1Q2xjSHFBOEw5eHFTb203?=
 =?utf-8?B?aG5QZXB4TXIwekYrcC9vTU14aTRnZnhlemROTTBzOVNuOFNpSkxQVFN6MHBB?=
 =?utf-8?B?dy9NOVkwRmtPY0pBWnJPMHpNdXkrTmU2bzRyUTJKL0R4OU9idHF3M1lpOWln?=
 =?utf-8?B?dFp6bTFlSDdyZS9VOWUzRm9ueDlvcitiTFB4U0h0Skl0enhjQVB0VXlycjln?=
 =?utf-8?B?RWd0c1ZySW9BUnVhVFRsN0RXTlczeWRuSkJ0NzZXMGE5TkRLbnFkTGhLT0RY?=
 =?utf-8?B?dFpnMUNybFZEL2tFZGZIblkwd0R0KzZIaFVEZHViMXdGVHdUL3NDdUd6UGVQ?=
 =?utf-8?B?THpMQlZveVE4SHBuSld5eE9HT05MeTM2cHdJYWRZVHhnMjRESzBFZEdoUEJr?=
 =?utf-8?B?c3FPZlZ0M05ua2xOSnkxR1V1NC8rSlV2NHpHaGlDa1l6YWt1Zjh3ZVJFckFU?=
 =?utf-8?B?MEFZdm4wRk4rUVdxdE9mK1V3REdoNTRMZG04SkI4OStBWGJvQk5sOU9EYkhM?=
 =?utf-8?B?SnpkR0pOcmJLY3F5S0d2cVFlc3ZrUGFWWTQ4RnZVYU9SaklZUDFia2w2UVh3?=
 =?utf-8?B?L1dnSHJQVzlVanpVSTd6cVdSdU5veDFzNENNcHl6SmJtYitid3BLMXJFQ3Za?=
 =?utf-8?B?a3VkYlRWSU95U2ZXS3VFKzVpenB1TjlIL25Uc0V5SmRBNjNVcHZWT2lhY2pO?=
 =?utf-8?B?aWQwTmE1ZEFBTWR3UFF6T1J5MWlPSUs0N3N3aHVtYTk1UFhDNXFPck1pdVFu?=
 =?utf-8?B?TkVxREY5Z1ZQRUVqYjZZd2t4OTZjc0I1b0orRzBvTlhDcjNScFZ3dzZCUlU5?=
 =?utf-8?B?dG52dE9GMDhCR2hmVDUvaWVzUWltMkFHMFE1WEFQNEtYVVhDL0tPM1p4b2xV?=
 =?utf-8?B?TjNzQUVEbU02cWtGNjlGaUtlMnIvcWxvTW1uTm5aVVkrRjFYT2EzR0dqL29N?=
 =?utf-8?B?ZVBocStxYTMrT0JrTGszc2lXaW1vbncxajgrakFZTXRLQXFxNWtkcGlOeEF1?=
 =?utf-8?B?b1Z6TXdWQ3F2OGYrNi9uV1hmdUZWWXZaVU54UFNuMzhNRktOcVh1dVVMWGpG?=
 =?utf-8?Q?P2Vp51D6qkXywsj7AZN8g+NZebQpQg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2025 08:40:58.4258 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c59a5261-a1a7-42f7-9b16-08dd2c9b82ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5730
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

Enable the cleaner shader for GFX10.3.2/10.3.4/10.3.5 GPUs to provide
data isolation between GPU workloads. The cleaner shader is responsible
for clearing the Local Data Store (LDS), Vector General Purpose
Registers (VGPRs), and Scalar General Purpose Registers (SGPRs), which
helps prevent data leakage and ensures accurate computation results.

This update extends cleaner shader support to GFX10.3.2/10.3.4/10.3.5
GPUs, previously available for GFX10.3.0. It enhances security by
clearing GPU memory between processes and maintains a consistent GPU
state across KGD and KFD workloads.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
v2: Updated commit message 

 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 88393c2c08e4..5ba263fe5512 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4740,6 +4740,9 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 	}
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(10, 3, 0):
+	case IP_VERSION(10, 3, 2):
+	case IP_VERSION(10, 3, 4):
+	case IP_VERSION(10, 3, 5):
 		adev->gfx.cleaner_shader_ptr = gfx_10_3_0_cleaner_shader_hex;
 		adev->gfx.cleaner_shader_size = sizeof(gfx_10_3_0_cleaner_shader_hex);
 		if (adev->gfx.me_fw_version >= 64 &&
-- 
2.34.1

