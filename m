Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 126BDE7719C
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2025 02:39:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB6D310EF80;
	Fri, 10 Jan 2025 02:39:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="onOHxNT7";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::619])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3DC310EF80
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2025 02:39:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yVks5assGEAqqEendn02CkwU8jJP1aYincAXbbm06K2kG9KyKnkHHH//P4cERFtTYKsVvXwE9mfQxOWjmuOanbEVX3ePFtqa638iJQkGbmDOclMndrUYtwocBhgfu62n9fVNYlB/gGHNs1pD2CyGvmGFADqhwhXAoAOYm1bmT+7sjSrtqMcuC9tBXyy0s9SoBJ6J2z6Emv+9B0kawBCxR8Hqi5HMXjaMx7Uoh5u0HmZXhnfzDtmHzfWsF2Z3EWsMnks+ekHeM3rNmb5WmV4bxdDxsLj68846X+4tciGHMi2xUGABm4I+vKymQ7HOInMRlz5gx+2t1bTtAO31h7EMdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z06M7ZmttsJUHZ93Owwn9V28m53/420vzWhk92b8Gaw=;
 b=Pshs+KZa+DCkBuPJ9LEP7jwci0xk/zZ6lvtMa0RSouAE03ruJRJtLoeOgqde7spe3HX14pryhhVwqm5bZVmZpKw4F1MFhYPP+kFthFzlhuLpFg5M8LcU/hXlZnirL0RHQZMmWKXt0x6h6fbJmm7VscqiSHN7nYPv67qYfVRFRWn1bc0CgcMED5CT79TthA3rP1+tYCP96gFNQpKxHPnsBFGYLDjA2/Z4urS4gz72eTq6u1h3jo+YNT5/p6IrOZfp36VntNAOHhYkHRoS7guTzxB85wKb9UE7TqeIaT6KFfN3iKO9GUXG7O2AU9WReGw5TJAVH0YqmOsLDQqvEueNBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z06M7ZmttsJUHZ93Owwn9V28m53/420vzWhk92b8Gaw=;
 b=onOHxNT7hCyRtyH/sSg3BzufbCvcHkGLtpFN2CoXANsQWbyVlEt9AUQttSobLAS4SqAhGSz+aSaHbxO8i2pOvcRxs8aWVqE3pNlClHTA6N8cjSThCSWj1ICTLxRdoytUebeBFngCmyb2IVw1JfavOZu2IcUgODwNK0UjKndY4YM=
Received: from BL0PR02CA0144.namprd02.prod.outlook.com (2603:10b6:208:35::49)
 by CY8PR12MB8244.namprd12.prod.outlook.com (2603:10b6:930:72::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Fri, 10 Jan
 2025 02:39:43 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:208:35:cafe::17) by BL0PR02CA0144.outlook.office365.com
 (2603:10b6:208:35::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.11 via Frontend Transport; Fri,
 10 Jan 2025 02:39:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Fri, 10 Jan 2025 02:39:42 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 9 Jan
 2025 20:39:41 -0600
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Thu, 9 Jan 2025 20:39:40 -0600
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <kevinyang.wang@amd.com>, <alexdeucher@gmail.com>, Kenneth Feng
 <kenneth.feng@amd.com>
Subject: [PATCH] drm/amdgpu: disable gfxoff with the compute workload on gfx12
Date: Fri, 10 Jan 2025 10:39:38 +0800
Message-ID: <20250110023938.13375-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: kenneth.feng@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|CY8PR12MB8244:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dd10d82-5adc-4121-bbda-08dd312009bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kKCuAsShwEZSWj5k/ZsxAmuYcapHJXlb4x/fBnLG025HREwKlFkxcyQXYjJo?=
 =?us-ascii?Q?2uOZv0bJ9H5Y+7fLkbVLOzQXtUeIN8X4WBlduQOaIPHD5fm8Ncz4FlN8F3Il?=
 =?us-ascii?Q?+fl9Q6RqTXgOIoaGefo5nuv37uqUkeYMq8O4hz1K5mR+Z6PpXEJODNLgctQR?=
 =?us-ascii?Q?Nfg6wYYJu/jqHWEhVozz/zsKbVWwid2UfwzV9P+UEBx/yZ495zzMVSeiApTx?=
 =?us-ascii?Q?zvd1eb1cXSUvOizHnhqdn6UwTQic7zT5tTcNJPJCUg5u/UE6pRF3p2H02NJX?=
 =?us-ascii?Q?Hdc8LqBcHbUY0z4meLgwrsTC5sPe/w8fRwgWp0JAY7cyQ9qn3PWu9n4kUkct?=
 =?us-ascii?Q?X1hVCl/ERJ4XWyOemBPIBboJ5vKI8a/BKoKASGJ2f2+qGSgc+a21Ni2tRFpv?=
 =?us-ascii?Q?4GfUigvpI1BoO5P0+Nwncup02lZu3tsBEkQki/s03DXd7rprAX7JeYhEGcYl?=
 =?us-ascii?Q?gRd9EKpHdeSQSE1NpJXteHHBqabFmAdxCAeeZ1IXiI6gaM78a9pXOkBg19fA?=
 =?us-ascii?Q?1ZpcWuxwPfby3RDx/KYdFrTAhc81w4sZI6wxEr6Gwps63ZObf17/exr+EU4Q?=
 =?us-ascii?Q?SH0HVyySt9BovCTpccBCWP24M5fMUeiDDQXY/ovmvsqHN8B37FkvAjzFpOVs?=
 =?us-ascii?Q?GJG4aZRApgS61q8DaI3x7Z6kuyOCOVBzha3Eb0IQbfwMsGWvYeaLkkMaCyvB?=
 =?us-ascii?Q?eKIf6ZW02iefx+Oid1joyVKkN2DQMtP4925J3YZDn7FPn7NMMljc4EWM+svu?=
 =?us-ascii?Q?L4BHOrjbjPd/jjiZSu0A33QbAu4UaEcrbEr6WbKKIxX247hJYEQBHHb42nZz?=
 =?us-ascii?Q?CMBOeLswNwLxB+WOndxW0lJ+BRajE+iAj9XIyGmSGXq0BUWmdbGJRAbdNeoH?=
 =?us-ascii?Q?AUk3f11tuZYCWm848Xx9fZsR036pw5J2fdpa3pD5OhzRY/viummgB8DoF/Bx?=
 =?us-ascii?Q?bBQ7I8HDjUnwzd2im4IwmfnWYU0RgBe6hBmEqD93symKn+32/xrgW6qBdXSS?=
 =?us-ascii?Q?X8nQ7k/eqQzaW2yS07CNjsceWpX81x0JV2hu1j5DaXkshaRh7sX7XqdGl72s?=
 =?us-ascii?Q?prWBEBOiXvssUBwWtJdrg/uR0Kh6mgSpJl7QWcDD4Z1FEcoGhX+30A0Zz4rL?=
 =?us-ascii?Q?7xvDWwgW/5NpMm9UeXMp8W9dX2qc7dB8cgSiSaEppwuZBRiquNwDnDMy+qPf?=
 =?us-ascii?Q?RNIW9JHvmTWMdkeH3GfyKDcCO5rFTXaWAMYqroasn2jf6Ae/FVck0szUQsEo?=
 =?us-ascii?Q?WIbtfNWx8bsuMcQw3c+YHgLFYHTZLMpwIaYUUxSy3k6JpkhhZUWL+tLE32GX?=
 =?us-ascii?Q?50oU+7k5Lu60yA7KpxFp/umgsLVL1rTRP6aWBNtEUqq/rV6AejlVEjUnZtKb?=
 =?us-ascii?Q?FSHuVBKDmihiiQiSWD0s5EdBFMKjzC0Nht03FjvlgLHost7ecabxn0dDMGk4?=
 =?us-ascii?Q?Yjs8lwNgrpWnr7SmgxO6t52PSYdi6fPZhu6MeJ3BY0c92rUKj0Qfjg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 02:39:42.7931 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dd10d82-5adc-4121-bbda-08dd312009bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8244
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

Disable gfxoff with the compute workload on gfx12. This is a
workaround for the opencl test failure.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 2e5732dfd425..2c1b38c5cfc6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -715,8 +715,9 @@ int amdgpu_amdkfd_submit_ib(struct amdgpu_device *adev,
 void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, bool idle)
 {
 	enum amd_powergating_state state = idle ? AMD_PG_STATE_GATE : AMD_PG_STATE_UNGATE;
-	if (IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) == 11 &&
-	    ((adev->mes.kiq_version & AMDGPU_MES_VERSION_MASK) <= 64)) {
+	if ((IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) == 11 &&
+	    ((adev->mes.kiq_version & AMDGPU_MES_VERSION_MASK) <= 64)) ||
+		(IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) == 12)) {
 		pr_debug("GFXOFF is %s\n", idle ? "enabled" : "disabled");
 		amdgpu_gfx_off_ctrl(adev, idle);
 	} else if ((IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) == 9) &&
-- 
2.34.1

