Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCF9ACD8CA4
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2026 18:52:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 300B910F8CF;
	Mon,  8 Jun 2026 18:52:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OgT5wj7n";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012007.outbound.protection.outlook.com [40.107.209.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65DD010F8CF
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2026 18:52:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BbWtViHuxa1OzAXmO+HBhiYupW8/cucclH7JtV4NCNW4SPXZgeWqFWn9nmRY2zVEP/zbb9E+fRuGgzCINCg3ne60A+OZ3bH4d5qzasDjUJ5YJgr9yJesc1Ly5hlhVdMgSrdYRmypYV/B1/4LwSg73dLc/txLBkU2c2u8PIZ3oBXQvaLDGQPDTnoX347Ep1VZ8ipySYyqSdbhGYieDVbYI2PBIcDpfUrqkJMmpPwzWAzjFXB7XNeaPozQpDOW/57AVbxTpoa5Deb5030SXvGrAuMrAc6Q40iLhbQ1ByJ2iOg2IHfrbAxxFNSQzjEekPyG5MRgMgvEFW6HueTiTJP45A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZqKKs6Na5Ovacy9xiSoLiGjOrPBKV9sXXaSDElOsZw=;
 b=MMH+3BZsRN96qlyTCKcfCAoV8GD1kYHEhgI00V2du5EzG1fG7GYbgQDeo/prI3GEC4AVvB0ccOAHRQnfX0sNHqG8jCvOen/gP2JjB+SN+gBEhfrfZNOtz4EwXP1AzuETxmNhJBZINAgQc722xzjD8pr0fCkvSEL/k+xUciYEdAr4Wv1TUzmGsXhgHId6E7GS3LDM2bO5VLrWhOhVTyAbCkgX9VbbvobqQSjxaEjGV12x+hAQm2Z+VsD64p9KcnMa4EtTckRF2r1pNvuYJIv7TtEPfX3BWTiKFIvkgkwpRZGiEd1gNIlH4zeBsSyFYJisRDpVrOqM+FBvThAoH7Tvdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZqKKs6Na5Ovacy9xiSoLiGjOrPBKV9sXXaSDElOsZw=;
 b=OgT5wj7nWWejoyF/r82M8gQkZ+vBspZXkGslFU3wjVYmyAXfoNzM19NZS+lwQe1lRFxEm9FzeJRofrldiUcOBhp/NX5QycaUW13ypYml50KgXA5XJZ9vjg2kGHZkUgmwwCEVXwGXKX0iL8SrWp2++wdwpc4Pxun6OHFZNOx/49g=
Received: from MW4PR03CA0283.namprd03.prod.outlook.com (2603:10b6:303:b5::18)
 by SA1PR12MB7342.namprd12.prod.outlook.com (2603:10b6:806:2b3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 18:52:50 +0000
Received: from MWH0EPF000C6187.namprd02.prod.outlook.com
 (2603:10b6:303:b5:cafe::76) by MW4PR03CA0283.outlook.office365.com
 (2603:10b6:303:b5::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.12 via Frontend Transport; Mon, 8
 Jun 2026 18:52:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6187.mail.protection.outlook.com (10.167.249.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Mon, 8 Jun 2026 18:52:49 +0000
Received: from harish-base-compute.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Mon, 8 Jun 2026 13:52:49 -0500
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH] drm/amdgpu: Fix kfd_is_locked under VF
Date: Mon, 8 Jun 2026 14:52:34 -0400
Message-ID: <20260608185234.503799-1-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6187:EE_|SA1PR12MB7342:EE_
X-MS-Office365-Filtering-Correlation-Id: c3c00f6d-bb0c-4933-e656-08dec58f238a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 9BbeZLj2DqiZAQJoXw70DVJNjW8ye9dLWzYeF5snNUYPWKoolnmGjsPhZcynZvZ46QAWv/d0XHTKSP3ELxOScBIqfwMha7wm01wjOLHPo6VR5CVrRy9zdGTgNvjrxtnvBTyjGjNGVtVKLK18AIW4WbzT98/G/KehXZydGgsjqOWD+hONgttsWx7NgstkaXaVhZbdRysn94Np7G/k0S6OLpMEKrUijd7QVvPexlcWuKayEfOTLARvb6VuvqO0jJPQJwqpgbGEq9v2yaRxWRRgggaqYm7Nym6tiqr29PA8yd9S1IRbH6iBKYAWyARKO78JGXn3C14Ws48zVgQu+I0DLaJMmOvEAMxv6d2Y1InNoB9LolINrrujClOwhRsHAu8i/qMxUsfYVV0yULTCRu5Q648gNZq6766BH6T7xfUSFUmhfdtqWYKv4F5B0oRz2sKd5gM2bPGiiZjalMqIFXs38r9fV6fn/Sdc+N4S2k44Y0qiG1+Hv6LrUVS9RgRdzQte0WogFD/vzI/0Bhw4nWrz3fVeSfxKYl6ltDHQJXmiOleEN+SUaw0WM0phL9z2jOIThkeVr87tbOkEpI+cyH/5qstqCJPDTKkO4qu2+z+7cQFIwmyjxcDRjh6kX2jDAk9kWPwr/+o40ZHMUdJUFK4ySElmkWQYD5O4YuRKVh+N8SelEyk19Vjq79AY1v+RGpA235lNMyGilwvfBRuH4TIWdiQ+NZ7f3Q6d7uXBIiIqKNc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: l9jax2A4srEc31RpEHM+nY5oC24fO4FpbaealxpfqtoKX5nhtrCCoFnLSCBFPgB0VcoRffAbqohlSZ10zmbBDrrbt2czldepojb8cemMro0L+xziGwjWUYcMUllIV/ysTXXRrQaK8BrmzXppxYEn40nZbkZczU/kHboLGpY3wTUHljbhi5Xyw++kqDBZlzZtAKJlbfFHi3GXhG1VFBfP0tok7+iu6K2TJSEA0M2VjoBruKII+xbJUR4rBeTJ+r3lmZH/0Qmmzzaj/9Ay1Adg2Vm/t9qGX0QTCuoMw1E2L7FI4prj1RvRnkO+DLK5WbscP4Ys5wlsw3Z9BMnqE2B1Ie5DpJBzGxDqw8fut3Nx/RstBiIZcnkvEayLdj0rKijkIhxa08xp5UO81EC4jdcy2Bd5rLxs/jHr61ubraCbxVYnj5tONUm/QVEHoF7dXpfR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 18:52:49.9156 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3c00f6d-bb0c-4933-e656-08dec58f238a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6187.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7342
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

kfd_is_locked remains locked, if the guilty job fence signals during the
reset sequence. In this scenario, hw_reset is skipped and
amdgpu_device_reset_sriov() which calls amdgpu_amdkfd_post_reset()
doesn't get called.

In bare metal, amdgpu_device_gpu_resume() calls amdgpu_amdkfd_post_reset()

Call amdgpu_amdkfd_post_reset() under this condition

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index dc8c650fc341..cefe1e5dd946 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5888,6 +5888,16 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	if (r)
 		goto reset_unlock;
 skip_hw_reset:
+	/*
+	 * For VF, gpu_resume skips amdgpu_amdkfd_post_reset (normally done
+	 * inside amdgpu_device_reset_sriov during actual HW reset). Since HW
+	 * reset was skipped, we must unlock KFD here to undo the kfd_locked++
+	 * from pre_reset, otherwise KFD stays locked permanently and new
+	 * process creation fails with "KFD is locked".
+	 */
+	if (job_signaled && amdgpu_sriov_vf(adev))
+		amdgpu_amdkfd_post_reset(adev);
+
 	r = amdgpu_device_sched_resume(&device_list, reset_context, job_signaled);
 	if (r)
 		goto reset_unlock;
-- 
2.43.0

