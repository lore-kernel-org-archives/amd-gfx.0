Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8DC5C48BC3
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Feb 2024 17:59:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 252B210E784;
	Mon, 12 Feb 2024 17:59:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NkPr8KC7";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2066.outbound.protection.outlook.com [40.107.102.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5784510EE57
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Feb 2024 17:59:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LN+BKLMIKrMtYsjxLI8qbTVwrH3To9k7zNZ20oIdeTfL6KoXvTV752qa/WNPKhk++iUvFYjx/+0QWqNdxi8MtxrNiVcQzKxYm40uXcgw5ad1oCt3CBCJk5AtCVRGgBMOmUwBGBdMxhQzn8ATCYpyUBbtWbWPa6Q0WzsDzRUGr1oK5+0uJZoqoEKdclzIsjDssP5njChH1jOaoZ9aH1YniLSRC1VDPMmhAAmnOz+Eo3neGlWsTzS5dZpWgdK4YC4yN/YXuzS8QXiZHYLW+RPsetAg4caJxrY1PzxKoi33BlP29kZ0YF6TmAIHDgn2QEuVR34JRBVgNkYlG+BWOcdTBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9WtFFcvHbvVEA3TfgvmKWDOM2W4OEtFPnug9uMxu7o=;
 b=TB395BDDT+61nucMykweugUhQMvOI9zJwMWVKgArho01STSRKjxOvJiV3hyHpDkgA42kFEIXHRCtZdfx4zoqfYtnmz42vkh+PQKpZ/FfPG9V2HwF4NXNQcODPuSYOq8HbzUXc6odkXfOkGJlI8mUPJFsFk41+53zamS2D0KWifuK9crXpbNzRlVFAJlQcQDRpI0If3bAefpnrY321hQyYMu8XPW3+YAa2+9ToV9WrBCnZUw/1PGvdfOeVuPolWEuQntBzwB1IS/bK7YBu/2DjKNqdbyNpt2h/0Oc6Y+AQvXThRQfxHppg+uQ62GJGNfoQXLxOWouX32RJG+84ZpuVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9WtFFcvHbvVEA3TfgvmKWDOM2W4OEtFPnug9uMxu7o=;
 b=NkPr8KC7Y1QrUa0mjv2iWpzgnQ49yml2/GoLjtCxgamT1qcmvOjCjGYHOpxinWVU44ICXQwtoeRUHN+ruO11NUcyvS/g1yw6Ngb50McByLkKVa17j6wjXfPQ5nXBOjcsThnQwU8sEG0aIjDVjLbf7w34cGS90NGSmnI+9sI3/fc=
Received: from DM6PR06CA0041.namprd06.prod.outlook.com (2603:10b6:5:54::18) by
 SA1PR12MB8743.namprd12.prod.outlook.com (2603:10b6:806:37c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Mon, 12 Feb
 2024 17:59:09 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:5:54:cafe::c0) by DM6PR06CA0041.outlook.office365.com
 (2603:10b6:5:54::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Mon, 12 Feb 2024 17:59:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 12 Feb 2024 17:59:09 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 12 Feb
 2024 11:59:06 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 7/9] drm/amdgpu/psp: set boot_time_tmr flag
Date: Mon, 12 Feb 2024 12:58:47 -0500
Message-ID: <20240212175849.433812-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240212175849.433812-1-alexander.deucher@amd.com>
References: <20240212175849.433812-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|SA1PR12MB8743:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d17addb-9bf0-44ac-21ce-08dc2bf44fd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dIgzFyPVL2wR0O76Bq7ZPb+kLAeSqx/Bj3892XiGcHATv/rFGAu84M4JfTiMsmPNBP8aGaieCliI1y9moFXEyZ5Sj91koXl9oOUEDAVdyp7MFMa/lpJ0Kuphx7D3ITJTqHi7TS2b2BfJO2pIovHW+yUwwx8IgF9sf5L7Fes+SVSYVLjfFMuXSOd7s/Gn/RT+4fbylQXEMfz/3Sk9Jymx0D1nYxE3vsZ20RT08HkiOSYc/aFFfgPM9rzwu4sPL3uWv17lxhz9cc5jThzMLIusBw/Zk0dm82K8oLRRwEArvIlYvmlvb1wcGDmfx9WKMovkoX9K9mxGAadHhlMnZaTvWYOnWJ0cp/6k74m/e2qcQGLAJrLCRNQTXgF5g6VU9IcQpFxtRdOgNVy06gg5u5zv7LfAAcfpKMV3gZAoBtjEcPowTYDVbD3xOZRYZRCvgCpZxoZRp1C0s/1GU/K/+hvc6EumxmcZKiikXth+2L56oYXZZSwEgmq92wB+hynIpGofeKjVFp0+M32/kystjVjgmydkr+l0yI08koBZr595HjeGzQJRLTzKM0giAYbMmJy/z0fLNdQFDv8MNyN1KyJdRGmzztoFf6Tp72E+w5UK8fU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(64100799003)(451199024)(82310400011)(186009)(1800799012)(46966006)(40470700004)(36840700001)(6666004)(86362001)(41300700001)(26005)(7696005)(36756003)(83380400001)(70586007)(8676002)(8936002)(4326008)(70206006)(54906003)(1076003)(6916009)(316002)(16526019)(2616005)(2906002)(426003)(336012)(478600001)(5660300002)(81166007)(82740400003)(356005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 17:59:09.0565 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d17addb-9bf0-44ac-21ce-08dc2bf44fd8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8743
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

From: Likun Gao <Likun.Gao@amd.com>

Set boot_time_tmr flag for the ASIC which MP0 ip version
newer than 14.0.2
For runtime TMR:
     Init tmr and load tmr should did.
For boottime TMR:
     If do not support autoload, skip init TMR.
     If support autoload, excute init TMR but skip load tmr.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 00a477a9e606..2151636d579d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -233,7 +233,8 @@ static int psp_early_init(void *handle)
 		return -EINVAL;
 	}
 
-	if (amdgpu_ip_version(psp->adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 6))
+	if (amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 6) ||
+	    amdgpu_ip_version(adev, MP0_HWIP, 0) >= IP_VERSION(14, 0, 2))
 		psp->boot_time_tmr = true;
 
 	psp->adev = adev;
@@ -813,7 +814,7 @@ static int psp_tmr_init(struct psp_context *psp)
 		}
 	}
 
-	if (!psp->tmr_bo) {
+	if (!psp->tmr_bo && !psp->boot_time_tmr) {
 		pptr = amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
 		ret = amdgpu_bo_create_kernel(psp->adev, tmr_size,
 					      PSP_TMR_ALIGNMENT,
@@ -2249,7 +2250,7 @@ static int psp_hw_start(struct psp_context *psp)
 	if (amdgpu_sriov_vf(adev) && amdgpu_in_reset(adev))
 		goto skip_pin_bo;
 
-	if (!psp->boot_time_tmr) {
+	if (!psp->boot_time_tmr || psp->autoload_supported) {
 		ret = psp_tmr_init(psp);
 		if (ret) {
 			dev_err(adev->dev, "PSP tmr init failed!\n");
@@ -2269,10 +2270,12 @@ static int psp_hw_start(struct psp_context *psp)
 			return ret;
 	}
 
-	ret = psp_tmr_load(psp);
-	if (ret) {
-		dev_err(adev->dev, "PSP load tmr failed!\n");
-		return ret;
+	if (!psp->boot_time_tmr || !psp->autoload_supported) {
+		ret = psp_tmr_load(psp);
+		if (ret) {
+			dev_err(adev->dev, "PSP load tmr failed!\n");
+			return ret;
+		}
 	}
 
 	return 0;
-- 
2.42.0

