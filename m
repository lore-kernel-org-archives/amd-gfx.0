Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC67E77188
	for <amd-gfx@archiver.kernel.org>; Sat,  4 Jan 2025 08:37:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63ECF10E0D3;
	Sat,  4 Jan 2025 08:37:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IMdCCTKM";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3EF910E0D3
 for <amd-gfx@lists.freedesktop.org>; Sat,  4 Jan 2025 08:37:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GbrOD+Dw/SNvqx+T1zpdlHkB9EdWF7iongotRp+0iR3r5Bs6mWbNvtLjHjnyVkyMz0p88ORBLOk38XLR66GpQMqWLTh4MawMp4a8qNQMk1dz/fpJ0G39Sr6wvNkGhkZsWzN+bGMv8+qhZS/xBZvezeDcPYYkmgcmVOrdWaRabzdXY0kNYOE/yt4j5BVXENlDqFuX+dccedoFAfYUtKAm11OjSyeBpdjemUZmRENYfHD2S6TUntbA4H9dD1G5qRUxmE2aOSk7kvMeKl9q7i4BwU4Nylo23njrtsaFR+aegxnQmo63VGK2apyaOS2ol7I+5c1D0AWEOYKjFYQ0CEOjNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UOv4n+F7whqDFQGjssDo91gGSUzCAzJqf9uEwpxPNAs=;
 b=in07B9IcChfKd+u80f5YQITU3gu0JbNucVE4PmVw00cHFkuTKE5QQ8nJaUx4I9a2kaG9NrgPTKy436lfjWPLhbWBhL9BD0dmn8hUddfFX3x5LIVwoLf05NswKRkwtmn9J6KN8wrslr35B4bfPEgkz/wpWBqxbRINMJw1UhWrUFXO3zxrSgMwXDqor5cX7Y96vYCLOk+NEacyT6Yfz8DSKkd43NFINACC9WCNH+hFJJIvrVgBSSO51tuzv0oGaWe6YDnbES35qb410tUUzYlVsEnmWxp5PbLOwziOA2RdzATXtuYRtJZwIYNnA+mU3Uqzec0246ddTgHImOjWzjrraQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOv4n+F7whqDFQGjssDo91gGSUzCAzJqf9uEwpxPNAs=;
 b=IMdCCTKMcAYGYTcyr9jRa0TC+W7jiQP2oGKOPwL9gfKWB7meq2yYGR400XdsnFTj5JTgZf46YcbK8ENSekRrX9umXazidSRWTt8NYtWMUj5LgWgOsSmCT31zOk97BhkSQ78yRn71KSwkyaeUcXX6xvtp0JAEMYBprPMRlcMMmhE=
Received: from BN0PR08CA0006.namprd08.prod.outlook.com (2603:10b6:408:142::26)
 by IA0PR12MB8422.namprd12.prod.outlook.com (2603:10b6:208:3de::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Sat, 4 Jan
 2025 08:37:14 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:408:142:cafe::64) by BN0PR08CA0006.outlook.office365.com
 (2603:10b6:408:142::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.14 via Frontend Transport; Sat,
 4 Jan 2025 08:37:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Sat, 4 Jan 2025 08:37:14 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 4 Jan 2025 02:37:13 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amdgpu/gfx10: Enable cleaner shader for
 GFX10.3.2/10.3.4/10.3.5 GPUs
Date: Sat, 4 Jan 2025 14:06:57 +0530
Message-ID: <20250104083657.3668894-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|IA0PR12MB8422:EE_
X-MS-Office365-Filtering-Correlation-Id: 1550a472-4bd4-4e5d-a76e-08dd2c9afd8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WnA3ekpIeDU5TXM5bFF0dXhWUGdFYnFEWFRiSU12NUU5YUZVcXFuZXhzM3Rh?=
 =?utf-8?B?OGVqSGRUbTZ2a1lrTFJ3LzBTeVl1bnNEUHlCWEZlNytaWHpIL1NpeHhxUlIz?=
 =?utf-8?B?Q3JxNlFoWDdCNDdUbUlZUm9ST2NPWCtIeC9FWDdHSk16dDhrUjV5UmovMGls?=
 =?utf-8?B?ejl3c20wS0dySHpyblNnTktlQnJDN1k0djNSekRLekVvS2ZaYTh0U0JoRlFx?=
 =?utf-8?B?RmxrRmJwY3RZd0hscDI3RnJJUzhoL1JOSWpQWDFWK2NhTUZtWjdFK3lQdFF1?=
 =?utf-8?B?MTY5ODdMN01FZEt4TFBPV29sVWR6Tlo2NEhocGQyNWdjYXM3ZFlhMFVGdWlB?=
 =?utf-8?B?RWhkN3FaU3lDNzRPc2R5cmJiaGw0Q3puNmVlQzZrbjhiY1N1eW1icUkrenJv?=
 =?utf-8?B?WnRBaTE5UzA0aUpkV2xzWE52VExNalRic3BmS1J1THM0QzJpQWxLL2ZDSVdG?=
 =?utf-8?B?TlRIUW1lQzA5dTR6VnVqVEdhd0Y2cWVoTjVnZnlORUJSUE1GOTZWKzU0UE5p?=
 =?utf-8?B?c3MzM2hGcXZWSVBPbG5ncmk3TU5BdDNoeithSUZnWFpCWU1hM20rQnRGRVZC?=
 =?utf-8?B?RlB6VW1kUWpLSXZQWFgzaGVWTVlibzdCbDVZSmdxQVFWM0pKTW1MQ1UyS2hm?=
 =?utf-8?B?aUZyQ2tXUjVycGNiSHBXbWpjRWVOR0k1RVVQNmZMNVMwTmV6WFY2WVFGMUFi?=
 =?utf-8?B?aWJvdmQ2TmlGVWZ6MjMxQVh0ZnMxaTd2bjdQQTRlVVVBSm5VVTlRUHVWS21L?=
 =?utf-8?B?NFdMWlVJQ1pHTFpjMnpXYjNJVHZ3UXhMYjY1KzYva29ocmJHc0M2U1BBSGIr?=
 =?utf-8?B?NHhEUEFmTi9DdDkrR1M1VzhCVzg4cjNUYXQzMGdXMXRNaHZ0azEwOGxpclpU?=
 =?utf-8?B?aG1XTE5DMGdmUUYxMjdmVGRoYWlzcXRlbHVodk1aR3loamM3eUtkaEZsS2h5?=
 =?utf-8?B?bGVHTW9KTUY3VTM2NytkUWtCRkRhaG16Ym9GWFRrdGdnS2ZEU3dXaTVUWFg4?=
 =?utf-8?B?aXFkdUczYnlrRjY4YUxsVkRCay84Nm12UUo3bmNCOTdMdTNuT0pOaWpEVVhP?=
 =?utf-8?B?UTBBVzhVTkplRWttbzk2S2hFV3F1RWdrVlZzSEF4N2lKRUJLVzFKWlpGWEF0?=
 =?utf-8?B?OGNIZTIxRy95dkhoU2FselJOc1YyaTlrQW9XWHAxWUhLUk1nOVNjczFlTVN6?=
 =?utf-8?B?d3ZzYkNGOTV5SnpYcjZzb1pSYnpNK3pXc2RILy9vNXZuTWcybGRzMjY0Y0tY?=
 =?utf-8?B?VzF1eVZ1LzlOQU95c3NNNlFXVmlIQ2NJWDlwQW1XUlBHWnF2ODRWK0k3SHBz?=
 =?utf-8?B?QjZqWmsxbCtjUTQxNjRLMXgwcHg0REF2Ym9aaEo4S0tHQjgyWmwxVXBBa2R6?=
 =?utf-8?B?Y3FpSnZYQ2xDdUlyQmxTY0w1V3pmQzZoeGJNK1hFRVhCL2REdlFDWnpqR1Ri?=
 =?utf-8?B?Ry9NNkQweFU0czN1RUgyb01nSEZFekJDbGdBYmduTzErb2lSTG5XUFBUbkQ2?=
 =?utf-8?B?MXBqWHlRazIxQTkxQnJkRnM0dExENjNDY2JZcllXbVJZaFBndTlGMm5NTUpD?=
 =?utf-8?B?RGZRK08xbysvU0ZUUDJDMWVzL2J5Yk1QRXNETFROUTViRjdLeHNHU0J0M0RX?=
 =?utf-8?B?RlZZRWNmbzVDNXdnMWR3ajVTa2tIYzQ0SUJKYU5hUzBKd21ubEFWM1Zic0x5?=
 =?utf-8?B?QkwwbWcxeHlnRmZZYUZONExUeG0yVExtWFBIQzdqRlpVVjNQc0RiY3dWVHZi?=
 =?utf-8?B?RnN6Z2s2UFhpQS9rR2hrRDd4UzlUTkluYUdlbFVnbHoyNEV5aGlyN2ZjY2k3?=
 =?utf-8?B?NkVzWkR5RDAwS3lCYXFvZU8xaWFXZjh4c0Y2bE9TS00yeDIxc1FVbUU1bFh4?=
 =?utf-8?B?VGxZT3lWaUY0eDM0dGRqVURJbCtWZzQzUGNQYnFnR0hDdHFka1dNR0owdWFl?=
 =?utf-8?B?bHQ2aEhZQ1ZkTmZjdUd3a056enJvSWhneEhwSDVSTkdhMlFzc01GYzZvRkpw?=
 =?utf-8?Q?ZAfN6a+DEbiQr4hDt/5fQJS15PFoqo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2025 08:37:14.6005 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1550a472-4bd4-4e5d-a76e-08dd2c9afd8a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8422
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

This update extends cleaner shader support to GFX11.0.0/11.0.2 GPUs,
previously available for GFX10.3.0. It enhances security by clearing GPU
memory between processes and maintains a consistent GPU state across KGD
and KFD workloads.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
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

