Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E81B103E17A
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 14:12:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A3D910E843;
	Wed, 18 Mar 2026 14:12:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5Cwg4nHs";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012052.outbound.protection.outlook.com [52.101.43.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75D9610E840
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 14:12:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yso9EfFDDaw2AFXqy8+r3LVXjmu0VCytrRf+08MIh5kwp4cUGVCSUpLX4r62A718bIqEY6CLECAic/soFvgdm9nL0UdR0Lz27HkS54s2R5DauVhemXifesyPCTq3iqnZ3H6sSj3f+/A0sePWqfQCiObnkS+s+oW6ugbjaZXm1JqIzTF0RcG+/2twnPzaNz9xSDo2tYt9if4E8sw7CG4qmrPqdXK/S180kkgHmnb7u5uN+72STVthkvcEJ5gsI7c3FX9qynmg7qSCqswFsu+GVLWIHv8uwzprz92xHoEUi3TSDtdua6c8+NG66AWX+QzdNwTi7xfDWPncLEVbp41glg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ng5XTOqjMTMg+Rom5OJy1IJSH+fNswoAmCbrg7EJFY=;
 b=CkdRJtx2P1jeq+xdi9+5LKFLOMiAE8pYatdjA8TQ6HuKPDeqMQORpmGtJs9E7aq0beZgd9bh2ds3mVgfw34x7zhFHQtDhbH724VGhmHQzF/PvhckU8z//WFnG6pbAOf4kBVoFD2px1a/tBLasl315nwegTFvuvq3fuseea0uLDAprGCqTUG8EMZ/SQGDhcJ95rluM/yRMjEwmpovcqBK3wShT8Tpe7J2hIDOtucrC2ifF7gWqD5aDeGln4EUNW23/wbc0kzzx77k5kc96NtdZ9iGymcBg2oymDoECjsyhD1EZUG5DHSKJSQ9Up4ic9PTz4RC6R5o6TeypOLjLh3dkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ng5XTOqjMTMg+Rom5OJy1IJSH+fNswoAmCbrg7EJFY=;
 b=5Cwg4nHs8N72Lx+7y3ZlG8vEFccDhG7B20EyGkyD2nVPL+ErcHwHpjd3Zp/Y/z8x5bPBAqG3sBPjel/znbUhpozJ+jT9Eiii+/U78M7wDTPDLDzYJ8CTYMR9KUWNSh31d3J/xkhaVBAzCeYIegsxh40iTuPnBedmCeaLkGJ2KEA=
Received: from BY3PR05CA0016.namprd05.prod.outlook.com (2603:10b6:a03:254::21)
 by LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 14:12:01 +0000
Received: from CO1PEPF00012E61.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::94) by BY3PR05CA0016.outlook.office365.com
 (2603:10b6:a03:254::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19 via Frontend Transport; Wed,
 18 Mar 2026 14:12:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E61.mail.protection.outlook.com (10.167.249.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 18 Mar 2026 14:12:00 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 18 Mar
 2026 09:11:59 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Mar
 2026 09:11:44 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Mar 2026 09:11:44 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 8/9] drm/amdgpu/sdma_5.2: set SEM_WAIT_FAIL_TIMER_CNTL to a
 non-0 value
Date: Wed, 18 Mar 2026 10:11:28 -0400
Message-ID: <20260318141129.583333-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318141129.583333-1-alexander.deucher@amd.com>
References: <20260318141129.583333-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E61:EE_|LV2PR12MB5990:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a1ea116-a557-41b2-ce9f-08de84f8529a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: jW+ptj71R8OS6+3MJxNtXI7t1VEj4tFS5wt0pz0wat6HCmQuiN508JUbwY/78Qtmr2Ibko8OJ/GLdUI/UhjPDdkmwR+1iwrSrvWyv2IEjkjCaAjmjBkTtJdtxHRCKUxRv5eSVU4saJVEpYrnzWwVsrrZmuN9Md+v5hhzp/zfGZjofnQb+7POeWVyYnAhSeBdqBr53aulVe/TBJSDlyoVGY6mzpJRNtca8wBJzjcr+lESiQR30NEoBVxCLY/1rQk9SKNXPLMbyjV3UNJc/DFP/hP+TBshfpuiiFgvf8eep9s3e26bD+9b+ZkgK6B4wWZFj9fBDepbf6kflRtk/VUjF1r7KDq328cndHsVZ5Ngiouw3KMAlM3uD4wRSnjSSJIYn+DKjOJIMxYFAe183grEk713xY6xOvAr2GZ/fLjRJ+YSxnrOPEnv64GhiIvVSO6gkUtxSbXLziJj0PROLBw4TJfhXPiwlA3bX9WnJlwHfKme3Nkw2IeURrFM8ellyDxGLTuZbj9UsRDy5+gIf5XrL1lV0Fhl25ZN5GhKLeKb9khHRNPTuHavQKnSPKZ1Kcckw8mY/4QzWyOFiTVNq/aBxjpxHtGpRcbjTxNyl3TS4oJpadN58eGWPfAeuFXV38+ndrwJSVLhXNBy7TYsYVQnlma9i7ZBP9qcIiZxrXMgexiv+Q1xgVYCfR1A7t/ZQTW5p2A6Bk1zY72aWgTRoH/c+mjVVQCaEi5I7iygYvWFAgd+4UKn0HUKCeN/cjbKfcHqcgHpH3Hgoy8+pp4IS8vq3w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: O7W2qeUZhYSNzLs4bTimwKgR+g4NfAoTCmKm4GobuwTpkqlQwLs48XkbGVeh6DPwNkOaUix32gsW1mic07r5ZqX0/RwNcGSA6PqMZwqqvVLsvk0b7jQVk9cgH0S4z2/kYQk5jxFCPOfkSJayIjvUhOlqtTqXvMdEE4WgRh0YvYTc9mWNiG3rm08fPTmN8fEek0IUjO0FXckhIk01xRgOnOsMuHRp6itu/te2mTJVc5l00+MQKmER0O1oV2kAN8DydYEFLuJsFbn4OaftxZVR30Ac3C9MpPn89jf/mdZYxY4yYzVQcXHHQT//ORcWZNRtymEUO2nSGUlsm4o5p8kFmW/y3fFtV4Yj2qrPBJ5mPANGjzjdS28XN+ZOhllBexfxAQAZoVs/Hb1TNpAIwk+evOQwAO7VpeArJq0E8yqXEXEjZj9i4r7f8defKBUBBRK8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 14:12:00.4450 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a1ea116-a557-41b2-ce9f-08de84f8529a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E61.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5990
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

0 waits forever.  We don't actually use the HW semaphore anymore,
but if someone uses the packet, set a time out value so we
eventually time out and avoid a potential queue or GPU reset.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index b4fb90cc8f7d9..bd97690f1fd28 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -547,7 +547,7 @@ static int sdma_v5_2_gfx_resume_instance(struct amdgpu_device *adev, int i, bool
 	ring = &adev->sdma.instance[i].ring;
 
 	if (!amdgpu_sriov_vf(adev))
-		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_SEM_WAIT_FAIL_TIMER_CNTL), 0);
+		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_SEM_WAIT_FAIL_TIMER_CNTL), 10);
 
 	/* Set ring buffer size in dwords */
 	rb_bufsz = order_base_2(ring->ring_size / 4);
-- 
2.53.0

