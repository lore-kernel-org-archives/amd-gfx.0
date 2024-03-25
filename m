Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F15C54E58
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Mar 2024 15:18:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D43B10E0F7;
	Mon, 25 Mar 2024 15:18:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qFx/o3DG";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED61F10E98A
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Mar 2024 15:18:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AJx1GwbGQDX0EIbNN/OTuLznnvubFkI4NOpWyzADbyb8qToXsjbmUHypxr8/h9owFT9oEWJOKjH/mkcZieNycwOd++juJqEZAD1MaMdnhvQ0xvvSWYvVhd2Okvfwfkm9ndAANF9viDvEqsJjnWoA4n5XNBz9mC0Gj4Q/imLysGLiaxJWa0WPkMxsOBNBB70130c6/0rlXc8xUXROOU8qNMjsjbm+kecbK0jPz0gXQDrqPpkwFrwkBCS0ZgrVs65kdYWvB+m+pqbJ/CmYxZXUhNkR/7MtpOEKWrWt6f3+v+ibjm3XW+TLse39iwagFQhkW7pMVoPMLY6rb3VGU50Y7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JiUbjbkvqBEfmnp+L9XgmSpIAEUerjV1IqDvbEStlbE=;
 b=VzwpxpUYQ6uaN1aJH/R649YVkMzeaorIcpjaTrb+/QGFQu7FHLQCRNoiJvShS0RCc1SZHAluQ6hjn8CYHId6hZs+aNT1D7WFCVjoQgHRf+Aooro9f4spNQUcOA2opD1J/Scd5BS/HnKk89Hb5oqtgwaY3rg1LaVRSX9EaDH6JplEO4egEkv75NiN6FF86sNYzUbA116C9JNTTTsi/3lOGofwOD4vDyHV61ifpSeDPei77NSEg9Ey/JVEYPlwPYJ9xIkGhg/c45vpG0vOK6AMEtNAT/5BS+07IILL0C57WfiZIwlMZQDvzNMLXmCFMLrWYoaZ7pLnMSZanG2yd1D8dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JiUbjbkvqBEfmnp+L9XgmSpIAEUerjV1IqDvbEStlbE=;
 b=qFx/o3DG1YHVanfJvjoufhvCMu56Tqt+77ACPvleuzxO+jNunF5/pKs+qxdvwgt5u11rNRIahaBp/ex9UHOvcu9n0zYnAXzhMz5ZmUxmo3loo2uaYvbiZNnq2UFQnRBdXMGBqu41Vc5SpT8RAVsU7CHaI5wwQUUFVpyU85Bpf7U=
Received: from BYAPR07CA0050.namprd07.prod.outlook.com (2603:10b6:a03:60::27)
 by SA1PR12MB6727.namprd12.prod.outlook.com (2603:10b6:806:256::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Mon, 25 Mar
 2024 15:18:25 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:60:cafe::bc) by BYAPR07CA0050.outlook.office365.com
 (2603:10b6:a03:60::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Mon, 25 Mar 2024 15:18:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 15:18:24 +0000
Received: from MKM-L1-ZHLUO987.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 25 Mar
 2024 10:18:23 -0500
From: Zhigang Luo <Zhigang.Luo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Sashank.Saye@amd.com>, <Jeffrey.Chan@amd.com>,
 <philip.yang@amd.com>, <lijo.lazar@amd.com>, Zhigang Luo
 <Zhigang.Luo@amd.com>
Subject: [PATCH 2/3] amd/amdgpu: wait no process running in kfd before
 resuming device
Date: Mon, 25 Mar 2024 11:18:04 -0400
Message-ID: <20240325151805.6379-2-Zhigang.Luo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240325151805.6379-1-Zhigang.Luo@amd.com>
References: <20240325151805.6379-1-Zhigang.Luo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|SA1PR12MB6727:EE_
X-MS-Office365-Filtering-Correlation-Id: df303c13-87f8-4a48-fd7e-08dc4cded0a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jo15mjInAMAnlt64/q6fXnlbLHwpXhcLe20s5lNdexxFBTX5nDJJaHZxUlN6id8pVwBHkxmsBjDnP6wqcHj60Uv8D1Up+pRe0QWUgQ9HtRmF6DOGDNpmQsiHQMkqMxf1fBDj0oC/BwMMxOGsbl95ziWd6/NE2lthUpq25fl0PO4dPLPLXFOGAWsNudqWc5TbM9Fv7NweAd2fheHRvFysiRc7ECK+XMCLJl/S9y9qTT+I6owyVEQnRea0IieebXX2BSzIrFs47iogYCuauoTUePGTETaHVNHHQeMO5dMZQMX+Ai/4HN2phplXsk5Cy9PTq3bD3Y03lROVyfabTSkiamgTi1CguWVLvSo/2H8trr4sKOO4ROssj9qH1nKCNd6WtHbYwDQDNtj7HLf3hQFJjJXHFMmhp3cvrPwzNRzhCunxc7ffg4rXR6v8cSNpDilwr1BU3fT4Phx11dEXxGT5aFzNXIZLQYfc/S/dneOfBvnalaCUItmqajwM8TymU0bfr1hZnOSaN/cEbfg4MzNv34g49x2chKbyGGjXQvjlPCYQggryOTlpyt9Rt+O2XCqu5uqJ3hKUI91KyweUI6726NrMGibFVlSC6SxDlptJFVARIOwh+oERVm+ZCJAVC+UNZpe2oik5ZVi1vUnrauyWTv24fYspjwGvFJifPh+NuW2furrKggfUt3COqnOOlUZHuozcxgIBM5daPqvajKRvBrBBlpDWJxithfOQcrbWbfYopAPMUTkLX7WheUJV4qKF
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 15:18:24.5926 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df303c13-87f8-4a48-fd7e-08dc4cded0a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6727
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

it will cause page fault after device recovered if there is a process running.

Signed-off-by: Zhigang Luo <Zhigang.Luo@amd.com>
Change-Id: Ib1eddb56b69ecd41fe703abd169944154f48b0cd
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 70261eb9b0bb..2867e9186e44 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4974,6 +4974,8 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 retry:
 	amdgpu_amdkfd_pre_reset(adev);
 
+	amdgpu_amdkfd_wait_no_process_running(adev);
+
 	amdgpu_device_stop_pending_resets(adev);
 
 	if (from_hypervisor)
-- 
2.25.1

