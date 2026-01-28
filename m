Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3855D3567C
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 06:23:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 878B510E176;
	Wed, 28 Jan 2026 06:23:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5L18HQlK";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012062.outbound.protection.outlook.com [52.101.48.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E50510E176
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 06:23:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZwibytLNJyQTTuN7EdDwfloimhtzHCYRzhjKtbKzOAvWMOW0OiZnO+ym5WynI0UsfI55F2VSYonsR7XrNJCyRsrhNTdYA+oeA++gocRQhjf7WxgPPekIFjmVpG+6Xepq4ObfWo5SmgYxQyBliCWACXBwa+ePzdzjCoo4nko3fa8J8LGekH/t2L3uAppj8gibWIB1Z5HlvM4y89TNxRLCUxXgGRp5LQ7Yom+4D3/n4JM0FwbMa9ltNn3SuV79eszNBuz+p04HiJUeOxipLlEwUwiPBq2zz9gq9tPE4JGw2oIHpI98wtafzxRUTldDmeYpuMjhmV4Iv2Hj7bTdv/IlzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=moA7YlKcNWmLw/JpKsx64j21fX2pGxBieWaOgaBUf1M=;
 b=BSy2iwC8pglYZXV7xnYTJati/6RWrL28S1sldqkoOAmLACbEdZiRGU4xi9AS0wi3wYtiLHRwwJKRUUJhoabHZFYmZC8mOxMRLXfKH78DwH0FF+IccBOp6ThFzpYfl5QRzqKiK+M+v6v5nfdW4zjK5U+qtd5NNZIrx0KI6SpgWqyYBdCHhPhgBQ4OEIY4Gz20pm6CN5R8T1foG0ncI/fK0bBhx6zL8amF6uz5WSHogHrIa2IjkA10BqbbAEdtEsiMA3zL1A8g5tvK6QExIz0ttBo22KdkIYx0gPz4T1NvY23EmkIK/inKjLGGCZEk8IZxYrVmAWIhcdtIlIAoyW3hUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=moA7YlKcNWmLw/JpKsx64j21fX2pGxBieWaOgaBUf1M=;
 b=5L18HQlKh5Os49bYD0nI1WYRPhdqwDhv3jR38Lq2S440BDh/fEBqGyG+6/Ruu0RA+3IBpQQh8n9uB/4TtnquzDkalbl2PWb9emRWyYHJqXoap2/nQqNGxsfs+XiYTosqacYtVtmulnWZJ39ubljcnxlcIqzexg6IwOC+WZCcusI=
Received: from MN2PR16CA0057.namprd16.prod.outlook.com (2603:10b6:208:234::26)
 by CYXPR12MB9338.namprd12.prod.outlook.com (2603:10b6:930:e5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 06:23:39 +0000
Received: from BL02EPF00029928.namprd02.prod.outlook.com
 (2603:10b6:208:234:cafe::91) by MN2PR16CA0057.outlook.office365.com
 (2603:10b6:208:234::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Wed,
 28 Jan 2026 06:23:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00029928.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 06:23:37 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 28 Jan 2026 00:23:36 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <alexander.deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: ensure no_hw_access is visible before MMIO
Date: Wed, 28 Jan 2026 14:23:15 +0800
Message-ID: <20260128062315.2848821-1-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029928:EE_|CYXPR12MB9338:EE_
X-MS-Office365-Filtering-Correlation-Id: fee600ca-bd86-40c3-5d4e-08de5e35c5f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kWxCdpfWZ3c/O7G7d0CVhcAcemBRkaU5cer9jEInaQ8YvYQsUQhJ9LQ674R7?=
 =?us-ascii?Q?MpZkiBS1hP12aCgunWTlzMgNP9Bq+SWZ5ADugeawMkL8qLZSRaige4y9WmeZ?=
 =?us-ascii?Q?pFEPR/cQeyDbyuyHIfCw/j7ANLUi+QU5mhD2N+d+TAOsZ1P5g8iyUBUBlU4o?=
 =?us-ascii?Q?44TXzjKBWpzndz8lnN53e88nScL2EeZaCPEVQEQ/3nr6x6ayZddy24HzbpXr?=
 =?us-ascii?Q?efdcOOFqaXxwIafi6uI2vIeBaq0Ak51pxC21uX2dgbgbZHdSTrbyQVPUTSX+?=
 =?us-ascii?Q?KgOx3nZOkkg7T9OH9LVvXvNCA8t7kOta6GaXtC+MfR6uwIcbRWVgbw1j3ql5?=
 =?us-ascii?Q?qy/u7eyURTed2Td5z2XK1/Za3Wr9PFA4D2PXslPRTHq3x6M99PaAemqxI93q?=
 =?us-ascii?Q?y3njtZrOaQ9MAjAC+t/51jPAqaHIOdo2Nel8KEtjkxp+N//2km9K1+FNAlOS?=
 =?us-ascii?Q?z5cK1whq40D91QOBoB8gExDxdPMgA8t/rp49YHrqgC+ewvBk/bLbXgk5Nfdp?=
 =?us-ascii?Q?qmGwvgWdu8/M2q1F52NsxQHn0w24vAfZaPG/YoBvirbxwgG4NtMQ9ZhFmEDS?=
 =?us-ascii?Q?AcIDvCjXR8ay+4t6mre6iu5Kw4WUNxTBUqR+1nF72M5gQOCgetfNro5fd2tp?=
 =?us-ascii?Q?ehxXJlUrhSI8IgB5WfTnSlmzi90rE19wHTROQOy4yCajnfUPo1CxEyWpwziU?=
 =?us-ascii?Q?nLEkxy8FRRJ4nXkLfO4zugGZpcR/VOYSSe6r5B6kQ5aB1LoxKzjv0QvrkSCy?=
 =?us-ascii?Q?z0/2CwS3wT+O08MhZlBs0CbBgKPEJFpGwDQ5GF903jucSP2QleUQ/5injV/3?=
 =?us-ascii?Q?tDMsSYqsn66BNa6gCDd9azcBXCsj75AuhEKB8Mo1mWEN78eJBE52j/hB1Hvk?=
 =?us-ascii?Q?quIQjEjHesOiwGTfq4/nFBCgmtaGTb1tbkoGmFL/5WLlCjKKRuwCJC9arXZx?=
 =?us-ascii?Q?atGZunHuHbFgmCN3diIWW98x/enBLiicXGOHHjl5izVnlgfCLl5z8OF6kNvL?=
 =?us-ascii?Q?fawYlMLBxZQUXcgyK5B51GENxB5CPUngsUbyhN5rvWGEf0LWOKNF/1UmvSXP?=
 =?us-ascii?Q?hybrfLY4wSCFmNI//NAU8eMETh/21mO0WvOsbgk+F4grkduE4HWGjPBCe5IV?=
 =?us-ascii?Q?yeGkkCx6Kd01qCC3rUecjDuene5PAWwvajQyWNdklqonecBF3kWEyfWgRqzE?=
 =?us-ascii?Q?hFsS1jpGzVXeTjwm2SMksPtlw47lYcyMBFDo0MTdiAlVTSKe3y6pi+4K1JmW?=
 =?us-ascii?Q?4bNdd1wUFDEuARINVxBTvO9Njm1zlNFKaVzNUV26+ReF6chv1fbuXxbYs1Ai?=
 =?us-ascii?Q?7BIvNI3tsDQ0r4N+437Eb5zOwv0FdqZwGzaf7KS0QKorHYDKPr0IWlOP2Mn3?=
 =?us-ascii?Q?88qrA0vZq9gncqZo8VCCKs54DmFrabFxRAfJNeTDLUwZengq7DfPDP4g+m5M?=
 =?us-ascii?Q?+xhp9Didkh7cOMaHpgJ4ht/UrXWQ8Ij8VNh1yi1CCUvaAR1JfVbHP72e81Rj?=
 =?us-ascii?Q?0rH+5HxyBrAiB1MCppneQjBmNu5l/3GaOEeNOIwqrsa6Dd9W6btcA+kTlMfg?=
 =?us-ascii?Q?Knf4yPTP4KmbqDvw8XWCeUvJqMPbnEm6q9P1Xqjo217g/2BORZDzTvvI2G1F?=
 =?us-ascii?Q?B2cYmLJrsmqu3KkrcxYCLSKPLu39+qV8dJ4VRueo7rTYUayoSzZW4KIe/OY2?=
 =?us-ascii?Q?ID4Fsg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 06:23:37.9905 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fee600ca-bd86-40c3-5d4e-08de5e35c5f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029928.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9338
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

Add a full memory barrier after clearing no_hw_access in
amdgpu_device_mode1_reset() so subsequent PCI state restore
access cannot observe stale state on other CPUs.

Fixes: 91ae0045130b ("drm/amd/pm: Disable MMIO access during SMU Mode 1 reset")
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b2deb6a74eb2..e69ab8a923e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5735,6 +5735,9 @@ int amdgpu_device_mode1_reset(struct amdgpu_device *adev)
 	/* enable mmio access after mode 1 reset completed */
 	adev->no_hw_access = false;
 
+	/* ensure no_hw_access is updated before we access hw */
+	smp_mb();
+
 	amdgpu_device_load_pci_state(adev->pdev);
 	ret = amdgpu_psp_wait_for_bootloader(adev);
 	if (ret)
-- 
2.34.1

