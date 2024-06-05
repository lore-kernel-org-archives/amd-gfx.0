Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10CB0C27C54
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jun 2024 01:33:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5090B10E674;
	Wed,  5 Jun 2024 01:33:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1erp9ohv";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2058.outbound.protection.outlook.com [40.107.101.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FCA210E670
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jun 2024 01:33:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8xAltF8OEjWXSTXhXzLIu+mQZ2wnoutj/VvHsvbQMdr6CGGWHhLoiE8iyGWbGjrBWy9W+rkByPJbiwILBEKhhIBkgz2C3XFX9zVFkMqAt99Y+kkUbR0+VWiLkhQAP6UJaew4H4THNwCjH5/1D3S7SqsaI57xUccbgC5sEOGMBqhVut0FerHdm5mTeQgCbF6DHyI1X0ILFj33k6dBhgLDs5HFER5zc1d2bimCTH4cCxtZZfndd6SDwoP7wgbhNl5xgpiDtN5C6OgIzxlwRVOhDDMd+HDBfba7qqZTnOY3J4b9m6ljc41fCyHm/RjWWGRTd1TquEwL1jDnZZFUOmUTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p60p6NUKH+g1fVUouFr6se1cpRATgLTqebzLE4eGImE=;
 b=N/Wgv/mO5GIpN9QAD8wqQbXWK7mxz7zSz4xGpV0ivB7SGa3M9itOzkDluuxR529Uuio1zwf8VXs0CE31QSP8opMyYtiwYlpfcN9k5dfYVdpzoiQ/EPPBCrg7DXCapGUkQbf42efY4/w8ODZ4sqZsq80XEItuJ6QHGGWqpqIsQQukTbv8MWFXMGkYVw98XEXMb39kw5hZJVejTfX7v8bbqMFnzWyqGLIm3aXlmwMbpFz+HBT3BDBz5x+S4zBYajrjELBeaM90gqv0c95r5KWzIyduxcs95rQsomslwFzi6krAgGCWozuBsWsW7nYZ8m9sqqCNqKLN/rGEdqA+bu84Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p60p6NUKH+g1fVUouFr6se1cpRATgLTqebzLE4eGImE=;
 b=1erp9ohvXz0ApdIAp8cun0l8aEw6I3UGno/FknK0uYx+ItKAJ4/9svWKcBOAsgdJy4465IaE/XwWsmzVYI9dJvzQ8pta+pLacCjDlkmXaYUOkYXbmz+Djhfd4mjyNzYiP+K8Ylqqnzs5E5MeGRfMdIwXiulE/aZS83EakGjqVKY=
Received: from BN0PR03CA0030.namprd03.prod.outlook.com (2603:10b6:408:e6::35)
 by BY5PR12MB4196.namprd12.prod.outlook.com (2603:10b6:a03:205::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Wed, 5 Jun
 2024 01:33:51 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:408:e6:cafe::ed) by BN0PR03CA0030.outlook.office365.com
 (2603:10b6:408:e6::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.28 via Frontend
 Transport; Wed, 5 Jun 2024 01:33:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 5 Jun 2024 01:33:50 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 4 Jun
 2024 20:33:47 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>, Yunxiang Li
 <Yunxiang.Li@amd.com>
Subject: [PATCH v4 1/9] drm/amdgpu: add skip_hw_access checks for sriov
Date: Tue, 4 Jun 2024 21:33:10 -0400
Message-ID: <20240605013318.11260-2-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605013318.11260-1-Yunxiang.Li@amd.com>
References: <20240605013318.11260-1-Yunxiang.Li@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|BY5PR12MB4196:EE_
X-MS-Office365-Filtering-Correlation-Id: 69adfdfd-194c-401c-4e3f-08dc84ff8d6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|376005|82310400017; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SFdpMjlOSWFDT3RrK0NOQjE3R2RvMjhsVi81SUlhY2E5VlZhT3lOKzc0Yjhs?=
 =?utf-8?B?Z2E0ejFnbUNKaHZZU2x1T3llMmFMM1FjeXkydnU2UVN1RVBpeE9SSWRPLzJK?=
 =?utf-8?B?RmEyU3FxODlJd0FTWlZ1RjkwT2QvQWZVR1VNV2pCdlFhZDlKRVVrZVBITmtW?=
 =?utf-8?B?NXVTNkRvQ3ZvT0NNQjFNMGZMaEdZQS9NZzZZSGovWGdaZFR0K0Z3RGo0dkRx?=
 =?utf-8?B?WTdTYXRZcEMrY0x3UCtDbEtuNzg4WWJSVDhMQ2o2bmNVN3FqS3dEOXpWWmtx?=
 =?utf-8?B?M3hhb1pIWERKSE92TVVBUHg0NjZNaVRjN2pKM0xhVEw0NXlaaFVrb3lENkMy?=
 =?utf-8?B?blYwOVl1Rk9wM3VmeWdveVYzZUR5aGp5Yjl5SkhMc2NhV1c0VDJZZm93bVN0?=
 =?utf-8?B?dmNNNW1QWmdpM0Q1b2w4MzdkT3o3TzA1UkNUdlArNXdhNWR0dGFLcnhPcmZZ?=
 =?utf-8?B?b3UxR0R5WkNkWGx6UU5WNHlEdlRxZHUwR3A2LzRTK0g4SldzZ2xoOENUR1pW?=
 =?utf-8?B?TlR1Uml0ZTNYYUVwRUJ5ZUhzTzYrbGw5Y09vZHhnOGpIYUJDWFlPZzd6dlo0?=
 =?utf-8?B?UUNtYUV0UUhaSUdZSldaQkovUUV4ellrcnR2eTRMc2ROUVhzQ2o3SWVsOW9i?=
 =?utf-8?B?alQzbHVMTWhYaFJiNW9yaGJJQ29BNVBpOXZsK1llZzZwUzNOUFNjRGxhRXRj?=
 =?utf-8?B?OHpYUUhjeW96Y0ZST29TZlNocjlSWVFoZnpLUWlrclF6NGlRaTdEVXNrRjdt?=
 =?utf-8?B?ZEdFU2RMaTdubzF3ZTF1ODd6NHhJcVV1M2tPZW5zdGpuRzdaS08vZmpFUzMx?=
 =?utf-8?B?N0hiVFd6Z3dQUFV4KzBhaGl4ZUdBeFlJdzE4dW5QRExsS2lhK05ud1RQNFUz?=
 =?utf-8?B?MTliOFNlOW0yTjRUOXQ0akhyRVZyRjczM3krQ1VyaldnUGx1Z0kwWk1sdEMr?=
 =?utf-8?B?dHdqRG5sS2lKTmNPZndPampGRjQ3OGJuQ3N3ZHNMWnFPejI5VDdHZERoOWpC?=
 =?utf-8?B?SldsdXlnWE1GWldjTktyQ21JMDA0eEY0dzJWTkN5K2c5b2dyS1kyQWVNRGRr?=
 =?utf-8?B?N29UZVI2Y1cxY1lPOXZuWktBVlFPZTlJMkZ1eGl2NzYvL0VZYnJzKy8rVTN6?=
 =?utf-8?B?Qnlhd2psWHVHUGVuTWdGSy9uemFYMWdOZ2hCdlFEUjlJQTZwNTU5c0c4dDVt?=
 =?utf-8?B?OHpndFJ0WkFQYVNqaVptOUlEMTZORnFoTnozOUxoNElvUkRFV1hzeWYxZEZN?=
 =?utf-8?B?YTJ5MzFGWlZrUHFpdzBnT0pvTDl6RGhRZjc1aEJBckd0U0E5L1hqRlpyajhJ?=
 =?utf-8?B?Z1g1M09iZkRyMVRPN0pHMlJBWHBHQ0Myak1CQlJwenZiKzZwS1I1WmxJejBZ?=
 =?utf-8?B?czd0MUQzcmR3VVFNYllOQjdXN0dxM3ZRUmJZQXA0bm9GRkFrcWNmQlJMOUxV?=
 =?utf-8?B?NHRiVUJpa0Z3SGxDRGpWUTdybjJpSUxkeUh3dGlkdDNhN1Jma3dPTTFxRnVZ?=
 =?utf-8?B?S2VYQXpveDR6S3p1TVNrZnZoZUdScFpzN011K2srZWpQMmVvUTZsSUQvR3A5?=
 =?utf-8?B?WTFBZDVMdnZXYWFkWDRTRkFEY1Yvc1dZZ1dSZVc3MzNsK1luNjA3UldOYi9B?=
 =?utf-8?B?cGRvczVuMktiRnliV2JlNHRnSjZOWnRMOEJLR2U0MFo2STdIWlZNdW8yVWZw?=
 =?utf-8?B?WkFjTzJ4SDI5dDl2MGZTcmJIQkJydEdydjM1M3YwR1hxcllVSU1ZVEdYNWFw?=
 =?utf-8?B?dHYwbnNXV3loL1JxRU9LMzNJVGcvbkVYSjdTbm44bTdSd3lPQzVlemgwTzhX?=
 =?utf-8?B?SjJDOVloMnphc004RzlsUThPRjBEMzAyUVlUMHo5SWd1TWplcGFYZFdqZEc5?=
 =?utf-8?B?dlcxMjFxMEdtMWpsYmFaRTh5T292QmxNZU1WUFM3aHdhRFE9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 01:33:50.3329 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69adfdfd-194c-401c-4e3f-08dc84ff8d6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4196
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

Accessing registers via host is missing the check for skip_hw_access and
the lockdep check that comes with it.

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 3d5f58e76f2d..3cf8416f8cb0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -977,6 +977,9 @@ u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 f
 		return 0;
 	}
 
+	if (amdgpu_device_skip_hw_access(adev))
+		return 0;
+
 	reg_access_ctrl = &adev->gfx.rlc.reg_access_ctrl[xcc_id];
 	scratch_reg0 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg0;
 	scratch_reg1 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg1;
@@ -1047,6 +1050,9 @@ void amdgpu_sriov_wreg(struct amdgpu_device *adev,
 {
 	u32 rlcg_flag;
 
+	if (amdgpu_device_skip_hw_access(adev))
+		return;
+
 	if (!amdgpu_sriov_runtime(adev) &&
 		amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags, hwip, true, &rlcg_flag)) {
 		amdgpu_virt_rlcg_reg_rw(adev, offset, value, rlcg_flag, xcc_id);
@@ -1064,6 +1070,9 @@ u32 amdgpu_sriov_rreg(struct amdgpu_device *adev,
 {
 	u32 rlcg_flag;
 
+	if (amdgpu_device_skip_hw_access(adev))
+		return 0;
+
 	if (!amdgpu_sriov_runtime(adev) &&
 		amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags, hwip, false, &rlcg_flag))
 		return amdgpu_virt_rlcg_reg_rw(adev, offset, 0, rlcg_flag, xcc_id);
-- 
2.34.1

