Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA16C021B8
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2025 16:51:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDBEE10E962;
	Wed, 26 Feb 2025 16:51:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LziU8OHj";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C44A310E962
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2025 16:51:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DavYFWs+dQvwYlpFhqo8Ekfsvn+UWw1cY0N3NTkvMygDUgu/+Yy5lMASi7jZzb5jevQWTyIDKCTNhPLEuixjHelagqjCOd1izh8TEQxrJXtb64I740/3Y1hzCZwdtevdShJ5iRg1xjMlEBdL2sywz/yf/edf8YxSoiJIgRkeTQ8kXzfDDQ64Co0qPz2MXjpHrpXizF2OneXdHzJFO7S0yW10W1XU1x7hOmuXeH19TNWjrFMV8pO7+Ova/ubD1crJkaMKcvDvRpuhrxek2uJ/p1HosMHuT2jnEB7tqiAQmMDc0gshur3+XmnbmIu7UYzJrXsSch1VIENabTHsZZ3+DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NImkKCohfH6l9Snc3Q2+HNoieL9zNpdsvnLV8rNXC6A=;
 b=v7cMvrQsawLH4DDlr6qXKmAR5CnlBIfUY4MXYOCu/Fr8ftBHL5rJkMRmjjh9BDLN1akn+D7BXT4BeFomw+GLlJAzk0oqJNbqyNf2oogQ9SOcF6528UBepSmgU4juss1tUKmRSjiop52jZFHNxxEn7aH6xVsuu8ebl43zdM7Qgl9V52M/+HWgzshe82+ayw8y8XwWpPz7tblioPqq+7Z0Ys6QIXzpoXDSaFd5fjczqOfIQ8g/h5gZB7JkRUMtZ9gaMaLNT5ywzaUJQDOaZ7zV02DxuCWhDOxjWCcwlyR1qhziCehU5AOwjgPYMsaqhPqjIikQBurO0a2FIyi4f3Vi7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NImkKCohfH6l9Snc3Q2+HNoieL9zNpdsvnLV8rNXC6A=;
 b=LziU8OHjWiBmaQ77Gfe2+MkrE9gY8qRh+a6qB6KnAWPvSCtQKjHGpmi7wV6zlK5mYfmgsriBC7ylJd7NMnw5DlBxNS7gnxEF/dY2vOfAtIuus0nQw17g3MN/W+fPuD7EMN1m4gJZmn56Kk3XN16/yjJjwVeu73BcaJ86Wy7zHsE=
Received: from BL1P222CA0027.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::32)
 by SN7PR12MB7910.namprd12.prod.outlook.com (2603:10b6:806:34b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Wed, 26 Feb
 2025 16:51:44 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:208:2c7:cafe::48) by BL1P222CA0027.outlook.office365.com
 (2603:10b6:208:2c7::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Wed,
 26 Feb 2025 16:51:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 16:51:43 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Feb 2025 10:51:42 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Fix core reset sequence for JPEG4_0_3
Date: Wed, 26 Feb 2025 22:20:48 +0530
Message-ID: <20250226165049.3152280-1-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|SN7PR12MB7910:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ede1d85-cf86-4852-7cff-08dd5685d982
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d3NoUExaRHlwV1FORFpkWEdUWHU4anpxdFBzU2psc0k0cGQwRExjeXVjZ2w5?=
 =?utf-8?B?d3NpQU5hcHQwdHcwMzVIRGgzaUZ0aHBtRHBqQVpqT28xK2ZTaWsyRDhRRnNK?=
 =?utf-8?B?U1VBUWdHZU9oRjdNZzlNdW9QbmFrdWRyMDIwV3B4bms2a2ZkelJKNFhDYUYz?=
 =?utf-8?B?b0ZHOXNkbHppeTFRZk13SkVvam1NTU8rUXBrZmJOUTROblZYalViRVU4SHpI?=
 =?utf-8?B?SWVaTWxkZENSNVV4S0JKZHBuOERoVzl2Z3Zrd0JOa0hKYU9Pd0c1VnFodHJK?=
 =?utf-8?B?ck11ZzZ0Vnd4anJOTDRrdFgvd2pBaVR0YmNhRVhjUXlabWFVdUJZZ3lLOWxp?=
 =?utf-8?B?cm1NTFRpd3JLSHJjMGQyU25EWmZwOGtxd3h2OVNzeFJScHFkSEsya0N3Zk5H?=
 =?utf-8?B?S3JZMVFkTHB1WDdEbjV5Ni9wbHhsNG5ibUJiU3ZOY29PeUhpMHZ0SVlwMTNL?=
 =?utf-8?B?Q1d6QmpLTmF0VWw5SzJCZHp0QlpUOU1pUXRGWjdVS3BaZWVscXNYODg5dGNV?=
 =?utf-8?B?ZjFGWU1Lbm56VjZRbHVYU0h4UXlDYUFuU2Q0STVZTzhudU1mUjFtbWt2YnFC?=
 =?utf-8?B?SW8yQUJiNjVNMU1qK2NpT1FXYVdhejRMbjR3ZjNZM1M2MXNmWmZIVXVEL2tD?=
 =?utf-8?B?QXlUSXhiNE96S0phQkFNVEtOTW5SeWRYVXNud2x0QUJjYnl4KzJCSzNIdERY?=
 =?utf-8?B?c1piYS9KWlZvcndDYzQwNDhKa0JZR1V1TFhZbTYvdHV0Ykg0WWFIV1ZuTUkz?=
 =?utf-8?B?WThFOSt2QktkZHU5bTBpdU1pMFcwdG1YZG5QeWZCeWhoUVJ4Rml1MDk0VzFs?=
 =?utf-8?B?Z09DL1pIaWR4eVlZNkJ6eFMycGM5ZDc1U0Q5NXdBWGl6elgrWWtYNlQra1dG?=
 =?utf-8?B?Mzc1bHRZUTJwbDY1MVUrSi9GSXgzUlR2S0d3SzIyeVQ4VG83a3FXaS9rTlFr?=
 =?utf-8?B?bk1KYlJ1ZjZzOXN0NkJDRzM2TnRXT0lqRng4V21KRmpnczhWVllWM3FVYzds?=
 =?utf-8?B?ME90OHlOeG0xWnZTK09mNC9HZGJMSkVlZndrSy9uY1piMWt2bTVEa2RqZ2JB?=
 =?utf-8?B?OG40WWlMTTY2b0d5TExyUHBPdnY2THNjMGZQdEhYYm1MVjEycjhOTjZQVE5o?=
 =?utf-8?B?MFVnRmp5NmRTT2UvYmNGSGpWb0lsUEN5SUcxYjVNSUVjbm84WTQzSW1BY1pE?=
 =?utf-8?B?VnZqRzRXT09iRHdodTluM0NVQTBBVjhrZjRRSlJVcGhmRnBGQ3lVaDN1dU5B?=
 =?utf-8?B?MFFmc1hhSEQwU0dPa0VOR0FmZEpVdlBtbzgxMlg1YkVldng4UlhuMkM5R0Z1?=
 =?utf-8?B?bkYzLzJWOENNcXp6dzZoZkZFdklWR1J5VzIxR2pwTE9ZMkFWTVAvTUFUN01r?=
 =?utf-8?B?TjBXTi9tRlpmRUgxZDBRbC9qZmYrajAyc0JTTXpPZFdpK0pjRkdrT29HZWM4?=
 =?utf-8?B?TElzMi91SkthalBBV0k4Y2lWK1o3aTFDMk9FbGlmNlNHeXZTWmNqQlRvMjZN?=
 =?utf-8?B?NGlZZkRYN01kd1U2UEQweWVDcFNhbFp1bTRsVmpQQ2tYYzIyenU2QmQvSDNj?=
 =?utf-8?B?bmZPM2Vxc3A0SldrYm9UZFdQVEtTeU5VODNQcUNsS09ONFJXT0lFRmVYSnNQ?=
 =?utf-8?B?Y3BQUVBrTnlFWWhtb1FNYkl4eU5TK0dvS291aUJuR3ZTQjBjYUorMENacitq?=
 =?utf-8?B?REd2SkRWclJDOHlRaTJTZFl1NGk0STUybnR4bmRrYzByNGNnSlQyZDJqSlRT?=
 =?utf-8?B?MW5JRndXUzhwL2JiSXdwNlE5ZjlyUExJZmQrS2RiSVhDeWhqRktWNUY2OUpM?=
 =?utf-8?B?Mm1uZEx4VEVZYnlzS0FmaXdEVHZkWmxoYjNMMjBVTWhZRytCRDNBakQzSFla?=
 =?utf-8?B?RkJXaDBOa2FlcEw5QWZJMlNTZ3dweHdoUGNHNU9KeXFybWtuZHNjMm4zMFBS?=
 =?utf-8?B?aGJIQUlFbFZPTzNYdlJyTVNlanNmTytEZmsycU9zVTZDamNhQ3VsdTZzcDlk?=
 =?utf-8?Q?JKIBBSjfHkT2kwPb/lsX/jeeYc/deQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 16:51:43.5856 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ede1d85-cf86-4852-7cff-08dd5685d982
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7910
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

For cores 1 through 7 repair the core reset sequence by
adjusting offsets to access the expected registers.

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index b8f06e9c9e62..1a28bc35385a 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -1104,24 +1104,20 @@ static void jpeg_v4_0_3_core_stall_reset(struct amdgpu_ring *ring)
 	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
 			    regUVD_JMI0_UVD_JMI_CLIENT_STALL,
 			    reg_offset, 0x1F);
-	SOC15_WAIT_ON_RREG(JPEG, jpeg_inst,
-			   regUVD_JMI0_UVD_JMI_CLIENT_CLEAN_STATUS,
-			   0x1F, 0x1F);
+	SOC15_WAIT_ON_RREG_OFFSET(JPEG, jpeg_inst,
+				  regUVD_JMI0_UVD_JMI_CLIENT_CLEAN_STATUS,
+				  reg_offset, 0x1F, 0x1F);
 	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
 			    regUVD_JMI0_JPEG_LMI_DROP,
 			    reg_offset, 0x1F);
-	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
-			    regJPEG_CORE_RST_CTRL,
-			    reg_offset, 1 << ring->pipe);
+	WREG32_SOC15(JPEG, jpeg_inst, regJPEG_CORE_RST_CTRL, 1 << ring->pipe);
 	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
 			    regUVD_JMI0_UVD_JMI_CLIENT_STALL,
 			    reg_offset, 0x00);
 	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
 			    regUVD_JMI0_JPEG_LMI_DROP,
 			    reg_offset, 0x00);
-	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
-			    regJPEG_CORE_RST_CTRL,
-			    reg_offset, 0x00);
+	WREG32_SOC15(JPEG, jpeg_inst, regJPEG_CORE_RST_CTRL, 0x00);
 }
 
 static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
-- 
2.25.1

