Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F55C27C4F
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 06:53:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EFAD112CC2;
	Fri, 31 May 2024 06:53:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WrNyxS03";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2084.outbound.protection.outlook.com [40.107.95.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A9BF10FB99
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 06:53:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kHVFGXdLbzWnkrd8ajBCI+gx7DsRoere3vchvntidJWbTZwE1GW+KrVkf9rfF1dLzb+cz1dCI/yRroRY81xqTYmYvVNgqaSUJ+JU3NG4pRD4P2cqAn4/KK5NusjE+eJgAoAHjsSGcvgPhxgH2nAnerYJp1WGwQt9X8F1yl9V6ajEkSYdqxTtK3pfV2kME0wd8yDgp10d0M2hDzQXpQcb2PF90vTGFI58JvSvOWr8hbYDgdVUeKTrMfU+30GRO035ORkEg2XXKFdiUW12E9Q0ixfxkW1JXkAFnKscJ6btGwT+dKoXewq/e4oGhPw7ayN2Z/KpwL9P0KTEcRrKC0Dkew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qyu3UwWPNcu6/45Ozefst1Fie6cG1kLQOD1UEWDERE=;
 b=ZDGMkRmKIViXJhJy+AFDmocAWo4N/jacp5Aj3g4Cup4H0Cn0GgtmGrg5yamUideRTWCwd7/2+o7PZefrDs216qI7+ah5Z/anRRS1Bkq7rrrYvMybeA3G/7FS2PYU6fPUhqdRYQDgDaRlHrtr2BnEOoBCI4GK8RrsSOLgLp+MSZLhBK1qQM2cffWycgiQTWeWwLVR39/QCzQx6Hsgsnh5Y0N/bm/+DTPy0xpiD+AlRu9UZFb3ucQ2E3+dJ3Ew714sF99AQHZgafe/OLjl4iEYxYi7vLhoEOTL3DuLlPJYXx6WBahO6BWbYUUBt8V7JKfZ+6RKE8Ijqb2DViVi8G+1SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qyu3UwWPNcu6/45Ozefst1Fie6cG1kLQOD1UEWDERE=;
 b=WrNyxS033C/j+38VSm/qdQOCT0JQ0a5wjFg0VGGTbmm/YRTzDC8OPHJsPi6T0ytrLzgx3GMDRlgRwiM+gMBOKehr+1PJMQgLyigOjFLOHoMx/9/BnSfz3VfjplM3WDEEyjWGDA6zD7YaBoTaTJAcEOJ3e9IF1fycQu2+eMAkWTw=
Received: from PH8PR05CA0007.namprd05.prod.outlook.com (2603:10b6:510:2cc::18)
 by DS0PR12MB7701.namprd12.prod.outlook.com (2603:10b6:8:133::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Fri, 31 May
 2024 06:53:22 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:510:2cc:cafe::c5) by PH8PR05CA0007.outlook.office365.com
 (2603:10b6:510:2cc::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46 via Frontend
 Transport; Fri, 31 May 2024 06:53:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 06:53:21 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 01:53:18 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 13/18] drm/amdgpu: refine gfx7 firmware loading
Date: Fri, 31 May 2024 14:52:44 +0800
Message-ID: <20240531065249.1746350-13-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531065249.1746350-1-kevinyang.wang@amd.com>
References: <20240531065249.1746350-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|DS0PR12MB7701:EE_
X-MS-Office365-Filtering-Correlation-Id: db0cf3c6-1716-4d14-c1a2-08dc813e5c09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|82310400017|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0BwLaqzaNAWU+2miH6acI7aWuDd+HprdmZhTO10m+0m18l9SCxEmgcOyoMV6?=
 =?us-ascii?Q?5FjIdtirelqyDvwa7cdMzyqpQB6SFQLhZWYMrIbrPYAn13wx6EXU0zffFcbe?=
 =?us-ascii?Q?tp3ny9eqCK76rXJkpXVa+EILV+W+xBslzZw/v9En4zNF4nwswOXr8qLCD/Kl?=
 =?us-ascii?Q?xh7Hrl13gy8kNQAZ8UGsq4fWKIU84kHg4MvgGIzdrfoROU9Xntnj2yUzbOxM?=
 =?us-ascii?Q?9OKsRqb0d9tRf4zwhUVGmWLnKBWBTxN1sYDXl0DGtAamtvAbKBkU1fpMm51X?=
 =?us-ascii?Q?YCYn7+VUKt9dvT6/WYGNxgJLMQMJjZ2QK8AQwDwTjhTDrWKjDLCp1a8D7jmA?=
 =?us-ascii?Q?RthOkyRIZKK67lo4g8zceEBi2JwstgTj+zhbCJoVFhIKuKHacERYqDVaqCY/?=
 =?us-ascii?Q?78+6RKybVd20QSmgRoRl5JmffeLedaFG7Dcclp60yZS55Jv4YhXjENA6KTzr?=
 =?us-ascii?Q?QZvOWctb0sNVQ3uYmwfQMYgtq/rPfRJ++mdfznsrE19RgnIvEKJzmn1MeC6z?=
 =?us-ascii?Q?NxYnbcModdhkAvwYaHPijKDbWv0ng3YzstsrsxpgaatJ0oFAfyF7WmGYd+0S?=
 =?us-ascii?Q?I13dfs2jFe2vcZR+VrYGGMUaWKKHDxuB68S5JNLSW85j8I8gzwFAh72Pd+Id?=
 =?us-ascii?Q?QFr/yX7wGqXlcNSevLXqjGfm3HbDWr+MOAAdILNoOCWeQNMdPSM2HNPlCDZz?=
 =?us-ascii?Q?CkRt5MjnNo1+WWha9TPv1rOXmQx+EQM00PnW65vEwBig+YdrJfVDFTojeUdr?=
 =?us-ascii?Q?zD51Zweni2r4gBq/UlZ87q9S3H8doSkui1kY3KC/utyPJXwul8sj5pPK71wU?=
 =?us-ascii?Q?wVL/mbFVPiFb+PXlft+MP6OTDDI0vDFpFzURKwnYL23sewKBZNK8w/QH4Rk2?=
 =?us-ascii?Q?ShTnGijfJMCACdrFqWx+zVGGmzxOKcl4dezFAvEjgdE8K877dyd4Grfsb0OV?=
 =?us-ascii?Q?QbOi3zekAKsDtR3JYQHU3FO47cn8Zyt7WtHrus0n4ZRkd8za8pSle5E8+1DW?=
 =?us-ascii?Q?m019ItwjF/g650Ckq7Lzi/1MF4enL5W2zb3YjLI2WhjUpPuLELSvgwY7oh5D?=
 =?us-ascii?Q?SO5nWIeGowhE5FoZFSfxHcOCauyYhECFYA0OxMz+MArDnM0RWJMcBkymKwuU?=
 =?us-ascii?Q?czg54c2I0f+3Qtc4FJAXqu6YOZs/OcABk4kJBSOf4i8xqQZtBGaumuocYQCz?=
 =?us-ascii?Q?ergr+KsfdyJfgjXh7V6+3zlmXGo7aGoRvJeH1QG5RsG05aBt2w7UpwedJmoN?=
 =?us-ascii?Q?oAha5XHa7W/GKPkP1VRpOQYmsmqtde3wq5C3H26W9IsPiP7byVbwsFvtbOac?=
 =?us-ascii?Q?pJhgD3zAeYqsB3zWgK2ARx2h1vEWrzs5zlI4nC90MM3mdnchqMOR3yNf2CMG?=
 =?us-ascii?Q?EWWASfvZZvYddVuyTLPEC7CuPHJU?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400017)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 06:53:21.0772 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db0cf3c6-1716-4d14-c1a2-08dc813e5c09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7701
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

refine gfx7 firmware loading

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 8f19b6ae8d5b..d84589137df9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -909,7 +909,6 @@ static void gfx_v7_0_free_microcode(struct amdgpu_device *adev)
 static int gfx_v7_0_init_microcode(struct amdgpu_device *adev)
 {
 	const char *chip_name;
-	char fw_name[30];
 	int err;
 
 	DRM_DEBUG("\n");
@@ -934,38 +933,38 @@ static int gfx_v7_0_init_microcode(struct amdgpu_device *adev)
 		BUG();
 	}
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw,
+				   "amdgpu/%s_pfp.bin", chip_name);
 	if (err)
 		goto out;
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->gfx.me_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.me_fw,
+				   "amdgpu/%s_me.bin", chip_name);
 	if (err)
 		goto out;
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ce.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw,
+				   "amdgpu/%s_ce.bin", chip_name);
 	if (err)
 		goto out;
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
+				   "amdgpu/%s_mec.bin", chip_name);
 	if (err)
 		goto out;
 
 	if (adev->asic_type == CHIP_KAVERI) {
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec2.bin", chip_name);
-		err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw, fw_name);
+		err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw,
+					   "amdgpu/%s_mec2.bin", chip_name);
 		if (err)
 			goto out;
 	}
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
+				   "amdgpu/%s_rlc.bin", chip_name);
 out:
 	if (err) {
-		pr_err("gfx7: Failed to load firmware \"%s\"\n", fw_name);
+		pr_err("gfx7: Failed to load firmware %s gfx firmware\n", chip_name);
 		gfx_v7_0_free_microcode(adev);
 	}
 	return err;
-- 
2.34.1

