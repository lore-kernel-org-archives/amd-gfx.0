Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8FF6E77182
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2024 22:09:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3663410E214;
	Thu, 12 Dec 2024 22:09:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0aSCWopl";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CF7B10E214
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2024 22:09:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJiralExS55Lq8X0GPfOvQsF6hPcCJOUn4qHwSfSmZTUdbjf7vKy+vDZQl5ojFzEmREySpPg2jCEspPm+qLsG9zdRJMqFy6M+rKI6G+Z+dFzCxqFh0K9oB4zYHsMXllaS5X9J/7d2Lr//eFYKPsptv80KM5/f+vqS6v75Xdqb3c4I+neT5i4Nvjjr9o9s7tqF7knM5FfcTmRgi5y5Rvv1GmUuYRe9Lt8b+z34cms2tdJZBgqSFgzd6DMYNpBPtgbTagZRb3os7uPv4aYn2mnDmFS3fq0Lw8HHyVqHUjKO63cK+5HkXDu/vui4uUz6j9eD8HrlCZD6O2k0dBrVbqyHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WdKxT2IbFwAM35XR/TcdqMHB4JqZAnSa+HoThwGTXXI=;
 b=VAipq18b8pVauXCROUsL3Fm7pp5Ai56rS64515N1g6o6lbaQPEEFJIIhE/sKKKdtOxujKvUBVqjJmLusYQSvmRJrDsLJvk5m5xUpaykZ84629HdOTxmW7TcajWrvieRkG2YvS/j5B3Kga5xk9q4yVH2bDSRHPFXi23OyOfv0+SFFmG4zn4ZgjnuxPnooi1/EbzL5ghwnpRQXpP43IhUk0hJJQ8oB5SY3pZEs4rVSG5xo2/Re/ALRGGAFOMdZM0sJO8GpCEQ5kTrlZAMJpbmIbqZ0tHpWUtaZzBkzz7lV7LRyLErD2+PEAmjQ+EwkWvpHlZHhslEacO2QU9aE83X97Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdKxT2IbFwAM35XR/TcdqMHB4JqZAnSa+HoThwGTXXI=;
 b=0aSCWoplaYTB2laftx+hNJNY1oqYVMZnYQHr4sCGcCjkDEJthgtaY3rKsXXjvZJspDLQPy/AP9oo2s+S3SDjsBpG6IZVkn6NdowJ4SYr1NeR0GbWdrG8+NxMtSBYUwwC6i0/wzUPUlhwnYlTr6dDUzLWvrwWMBXyLEBOR4cPMc4=
Received: from BL1PR13CA0262.namprd13.prod.outlook.com (2603:10b6:208:2ba::27)
 by CYYPR12MB8729.namprd12.prod.outlook.com (2603:10b6:930:c2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 22:09:12 +0000
Received: from BL02EPF0002992B.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::68) by BL1PR13CA0262.outlook.office365.com
 (2603:10b6:208:2ba::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Thu,
 12 Dec 2024 22:09:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0002992B.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 22:09:12 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Dec
 2024 16:09:11 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/6] drm/amdgpu/nbio7.11: fix IP version check
Date: Thu, 12 Dec 2024 17:08:52 -0500
Message-ID: <20241212220855.790502-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212220855.790502-1-alexander.deucher@amd.com>
References: <20241212220855.790502-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992B:EE_|CYYPR12MB8729:EE_
X-MS-Office365-Filtering-Correlation-Id: c2b96c76-faaf-4dca-bb44-08dd1af99c06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VU25fTPLOWDvcbtUIA/2GFVBsbe1eWUtW2RknhNuIuBvBnnYGn0yNawnrv35?=
 =?us-ascii?Q?0d4etqn/fGi0+QjHRSCClAREVd2HCFIoqBsEDASyBVOfOHh/0ULAGo+srRr2?=
 =?us-ascii?Q?09bq8629++u2Zl3IRprKIhPtg9aoKu17OHBEnMVLfB2wvqe9ALDyqqioOQgO?=
 =?us-ascii?Q?AA8p+heH4MWCa7gwTXIVKxyYANhmFNg4Zf5FxkpMSivIUxwGxa8wdV0zX2jz?=
 =?us-ascii?Q?ttwy2E/TJ2ie+igEJNkEyD1/+6c3nnS/kaD9ieLwVswfS1N5FZS598EH9u9o?=
 =?us-ascii?Q?jzh6Ac+9tzRSn4VmWaP/UmuvkFA6tSwluqhDB8K7Zx6C7JsxYN6N/7oCDTMZ?=
 =?us-ascii?Q?xuei4ZHdbdp8CPu+fj9HVOE+Uk3VcUTlwxSVCBlryssBNbFNXu2nyA4CGcyo?=
 =?us-ascii?Q?optzkTOF+2BcU5/LGTVCKAFRkFld2GVuvMTWTy1uBK+KnyXEW3FdhXk3EyYE?=
 =?us-ascii?Q?yWJwkLpxMBvEW4udmlEf9QGsHFTLG4jnkl/LGsEcLCqQ2tak6JtH6PM714Zn?=
 =?us-ascii?Q?/nRTD5xLYlxZYzljKiGvAZ9QaVU4mw6Zp3zk5SmPMt9SUXjLsKuZau4BbQR3?=
 =?us-ascii?Q?ht+7zcW6PrecMBq/Nr49JJlGXtUt9Fzj5meriXcs7OyajBlYICMT7tV8XRCp?=
 =?us-ascii?Q?7NDDHnZJEBX0wbZmrDrmZokl0d9+cBZJGgoRbqOSk79nXLvCs8cUcUH5Slma?=
 =?us-ascii?Q?KG2hjTLlVOIrv/veo6Lwh5BSn5CILtn5d+BMJBrOMxh96IZjdiuhppdytNph?=
 =?us-ascii?Q?G0uReHiX8HJboR09Fsw6Jf562Csh1dbK8zkg4RGVcxSSNqDlDHAw1ZKmrtMf?=
 =?us-ascii?Q?MWCFc2Z2X242Z4XTsRffV/85V1A3Baq4nugxr5b43KgA1QeVzWYAFRa/MKH1?=
 =?us-ascii?Q?of8GdK74iW0CHEi6dgO8LLu/waSOLCCMnnBB/BOn0uhiM7XgAk1VFQxKibWI?=
 =?us-ascii?Q?9RXyvuPxCV4evOu5piYDTVKEY7XTRv552wM1FUkUvqvwHZGpW4iOesmjO8ZG?=
 =?us-ascii?Q?mxY9w4NfswUSk8tt98NX3Stbfyx5wCYJ98ZXqLT+RmXYs6Cplt4Nz7OeoNHx?=
 =?us-ascii?Q?wPdOgPim8DHjw2IfyHMklMWCo3XeeSm2M43ipRg8m559sd+0tUOfFZ7ilGZB?=
 =?us-ascii?Q?MS23M/YeCbEzQxGyYTIaqAGV/wB1cbc8Pt0vvmxE4/iI4NIeMVNNVqSUf0hi?=
 =?us-ascii?Q?qgYlkrbZk6a/xKKMBn3z6Cdw+Ptob7/0pyqIQmGspcVI82ovEYuL+9Trcbec?=
 =?us-ascii?Q?feX7lBvhUgX4j4PhwLrRFMgFKtlF/kXbxQiUV9h5m2uusCFPlgl8ilXAW5Ji?=
 =?us-ascii?Q?q8TdmPHdxMF5UTxgt1sgA/eA2pNDUgHhaPVNnUDLdPFNdBLEnuGBZB5qx2qI?=
 =?us-ascii?Q?mR8UPduDqyv3QlAG3vFeDDThzsH1PkeDWmrTV1X+xsmVNyfZ31W0f3CtQmXJ?=
 =?us-ascii?Q?Qhcxh7lbXB1yZsMrMUw3UU/Op2wGrV+W?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 22:09:12.2562 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2b96c76-faaf-4dca-bb44-08dd1af99c06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8729
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

Use the helper function rather than reading it directly.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
index 814ab59fdd4a3..41421da63a084 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
@@ -275,7 +275,7 @@ static void nbio_v7_11_init_registers(struct amdgpu_device *adev)
 	if (def != data)
 		WREG32_SOC15(NBIO, 0, regBIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3, data);
 
-	switch (adev->ip_versions[NBIO_HWIP][0]) {
+	switch (amdgpu_ip_version(adev, NBIO_HWIP, 0)) {
 	case IP_VERSION(7, 11, 0):
 	case IP_VERSION(7, 11, 1):
 	case IP_VERSION(7, 11, 2):
-- 
2.47.1

