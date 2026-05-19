Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D999CD4F3C
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 18:31:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2487610ED73;
	Tue, 19 May 2026 18:31:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JugDC46N";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010023.outbound.protection.outlook.com [52.101.46.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4225710ED73
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 18:31:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CDBC1YH4otVFA9DIzoHqkpYAmj6401hLL8LASVaUYpO9dhOZhQZAXsJIpbHG2nJyL/Ug0cP+F+W0bUhoVu1VKQVTHheSy/8sD5vKAK5+/T9Qd7E5zPIIh2mizP0DxXBYrH20M1DCVL9/+GCO3ABnTvaFwKFgyxwQvuhlufz8/aa4W7VdkiignMOkcKTmhfkku7MgGWiH0zzzYLrfUKHPVCgUlea6rSgjUqF79sMephfSVByXMWCpEJ48e5EvW64gAWwFfLyclhZsk/9qqTYd8q66+JpY2qVq01u0bvt+cLDkv+h7bGoY2ZZ8VklGBjtHnRNzTSnrqKF6RxpdtKuEEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pO9Vscx9UShsB8128P12549f4w/jKZ9Z+TqTVOietXI=;
 b=XRfFfN09SJCJa0znHR0UqaWdXgen8s1w2Vllgxfi2o+h+baL4ezW0KNQTPCk8Ywqi30BeQIIfxbH0M0tSK8zfneevxu5CJ1Dnhfg1yKkAMz5NaS2Ch8DBjUdXw542Y5Hw9vsdDIMIcML4Q4TBNY/zUMJ6YIj6vQfay1Svpw14XvzjE+j07jufPxmvTUVuz/v2LsayyAUg5dlBrfLZKyypdHZPXHoGoX2eK7+W3keApcbEOUO12P/P0Bgk11SGZha+VaOXx1faDku+7hCJniF5/KVoLF1J/w/T3W94+Z49mxwggUQSxN6rAyVVM0oEz0GXKc3KsrTdjOBXcEgbdtU/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pO9Vscx9UShsB8128P12549f4w/jKZ9Z+TqTVOietXI=;
 b=JugDC46Ngmt0J33UlzjHH8CLl2EYhbPYU7T405QUK9/jxuAJ8SNef6IKBpW1fKiDIepu/SWLlBL+ljXJARPMaVA/4D67dJFp+9+wKPMnwhHga9DTOp/kPnEec8CKO9C+PdWW472GoEWlVmyGUKp/eOkEg3SsIy+PJ8xHtTuv+NQ=
Received: from SN7PR04CA0092.namprd04.prod.outlook.com (2603:10b6:806:122::7)
 by DM6PR12MB4172.namprd12.prod.outlook.com (2603:10b6:5:212::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 18:31:10 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:806:122:cafe::43) by SN7PR04CA0092.outlook.office365.com
 (2603:10b6:806:122::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 18:31:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 18:31:09 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 19 May
 2026 13:31:09 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 19 May 2026 13:31:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/9] drm/amdgpu/gfx11: only need to remap KCQs when reset via
 MMIO
Date: Tue, 19 May 2026 14:30:48 -0400
Message-ID: <20260519183055.22275-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519183055.22275-1-alexander.deucher@amd.com>
References: <20260519183055.22275-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|DM6PR12MB4172:EE_
X-MS-Office365-Filtering-Correlation-Id: 55476f70-44b7-49f7-7162-08deb5d4cc21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|11063799006|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: YkphIDg0WVZl4/lcxgtXcrw1JCXJzkl91lusOxGhAlN67F0Ge0OfRD56NiAT6mUNOBthoBfeQrJDYR9GkgDsbyhC1WIVv69psocLOJZsxcbRFbJ5iitmyN/YYFaCuKJc8sk7n9JVuSuald+Gf0CvYj49NGa/sXJI7uOxyZn7oB1e/GVclL097M3ho55hyf6gJmM6VVBo1veq9iIIGaUZFXh1wuvJGn/eDyZ5sBNwOblbmP4KYY6hgbk+99deGzWruw+pViRUP0Bd1pNcaWlmKi+8ZsciBPb5vyNXbygTGNt1p7sC2EO3YulfuOBEITYhbf2Ey1qfoNVSIWka42UxQ36d5u6nyq1n50+/qLcm2lq4DE4ZK460KIVQCX1Mz13zNfk/rTl6AZ+qJ2rBBDCeipw9IcRrdagzRMxTv9LZfU5y6vGB7GQBS6lPhk+GfB6ZSdITw2dfOqjPQOGzTIYNaGceaWHhqov2v6aMDiRuoa8reuBDEjGmltiM9mjn4W7lW/HcdJDnCc9whGF0Ylu4UTe+12FqdlvGzo7prLDJ+riBXLhKWukgqMnJ4tnOP6EuoiYzP+ZG+rKn8aK8NvjDnc0Ljh7/mv5dV4e1LaKn4XGq5Oh6HQCdwiox3G78r9WLumIYtA2ewyuUiC9VarReE5GnwjoyrXv23RhmDef74eEFqG8S6Mn09hFO9pUUKmzIYlW6NuP72Bd69O3z5PTB+uH2GLZ81mKQH+0YRieUDcg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(11063799006)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ULaSVJlT1EnJfSPtylTW8rta1iAHXpL5BIoUr7ABsgOXtS7Zs7n7Hiv21LTvYxebZ5GyB/okP6pCEalwMEtzWdOcaO8jp32B7XfjZdeRYLp2sWrCSmluGJ5pmwgOzN0Ku4R/looPjWRyHY1C8E1kBVRIrNgfVruAogQ16cF1NjvdyRdsw31if2RGYWscYm4wXKJTSePVlmbStlvZ+kCZeWpKrTZO9Ytw6/b4L/WEaWJAsIyUdEWM8uj2NrVIBK9ycxw3nqlq8TQsNeD0h8481UXXD66qx8fDgnycHzzp6H5QjN+bD1HWRYB3O7PWDcI/a7w3dxPHQL5o9r+u7b3JnlqL1FueKfSa+zWBDT43I4lJggjeJKR6q1z6hFVjrwXHZvHp8TQ0mtFY9jH8yyDEfUQMEvm7PuE8GaqdhJgwed8IhW4Tkvi+pfWxUmc4IAq+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 18:31:09.4999 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55476f70-44b7-49f7-7162-08deb5d4cc21
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4172
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

MES remaps kernels queues as part of it's reset sequence.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index fabdbbd0abb7c..dd4f33d2ce45f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -7009,11 +7009,12 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
 			       struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
+	bool use_mmio = true;
 	int r = 0;
 
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
-	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true, 0);
+	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, use_mmio, 0);
 	if (r) {
 		dev_warn(adev->dev, "fail(%d) to reset kcq and try pipe reset\n", r);
 		r = gfx_v11_0_reset_compute_pipe(ring);
@@ -7021,15 +7022,17 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
 			return r;
 	}
 
-	r = gfx_v11_0_kcq_init_queue(ring, true);
-	if (r) {
-		dev_err(adev->dev, "fail to init kcq\n");
-		return r;
-	}
-	r = amdgpu_mes_map_legacy_queue(adev, ring, 0);
-	if (r) {
-		dev_err(adev->dev, "failed to remap kcq\n");
-		return r;
+	if (use_mmio) {
+		r = gfx_v11_0_kcq_init_queue(ring, true);
+		if (r) {
+			dev_err(adev->dev, "fail to init kcq\n");
+			return r;
+		}
+		r = amdgpu_mes_map_legacy_queue(adev, ring, 0);
+		if (r) {
+			dev_err(adev->dev, "failed to remap kcq\n");
+			return r;
+		}
 	}
 
 	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
-- 
2.54.0

