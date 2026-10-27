Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D163606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 12:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Ybusnr0V
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FD1210F49A;
	Tue, 27 Oct 2026 12:57:03 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013058.outbound.protection.outlook.com
 [40.107.201.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDE3010E308
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 12:56:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eB2eYshKyo5Ehrm12SgtMPE3Qcr70ZmwrMejfaKH57D7A54fwFVaspY4uF8xcbSCzFgcy+GIBoPAVUYlDWUZyPzTMG2HyAvF2rd/ZDjhnv6dV5jr+e8dwio2jgGYxgdr4NUVPVCCvj/AAkskObX2Xls7cM9xYZOxU+NGoW4dp1hJt/1bpsk8/fZaCxHjSdatMvEsjqrF2uWaLbngMxiJomMYxeRM/jTcAxA+zPMlKSVN7vFTjgoOC592713XKjVVGs2Ajr1QokZT+AGoTWz8GTWK5cTqXRXWf99kgJSUxiFVpcG7Aolsiltg/hXCeGR3xv88QjN8iEfG0Sn7DRg4Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jx53frPG0FHd2w8Qg+HKK+MoOskJ+M5jpL2f4RsXOZU=;
 b=kh0pPDtd3UV9dXTAk5W30jsAHhT/ke+X3cDuPUXLbij2KqQ8vd1WMTme4qBHOEqIV85oRsVqboNjssjluLECQJKl7v9XM/59Bct9zHl6D/vWWBlKPGyYNOu8dBV5XmPVPzPw8mN1Fq+BKWpM8VbpgGoEp4tcTiKZvvlDO04Q47YoOz5Hx5I8Mu76xvecaym+YHvorP73NzjAi+LyXy3GNHWVU/SKfGlyDEMKQAx7nm9I7hJTXxUOZxj+f3Vb5SWKGP0VmbGJIykYXeZsMn+T0Mp6skIkCIlGRP4hdKsiLXLFbe5aHJ1yjhm+qwLRaBXB3WL5Kdh9OStg5GJ7ZyvKUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jx53frPG0FHd2w8Qg+HKK+MoOskJ+M5jpL2f4RsXOZU=;
 b=Ybusnr0V5Hn7GZKDMKa8mL9BYlt3rU25J6Hfd3arrewqXd82dyaaG6B3LRq15Xhorgrvusv0VS11XvmDVPt34Cx6bV648YNU3P39L9W30INWNgDPPYwiVRkS0cGCHZzLUF8RT1YQWRX+I4+scJ+RnruZn8ldWjb2vYNVSFh22tE=
Received: from PH8P220CA0027.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::8)
 by LV2PR12MB023797.namprd12.prod.outlook.com (2603:10b6:404:301::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 12:56:51 +0000
Received: from CY4PEPF000392DD.namprd03.prod.outlook.com
 (2603:10b6:510:348:cafe::54) by PH8P220CA0027.outlook.office365.com
 (2603:10b6:510:348::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 12:56:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF000392DD.mail.protection.outlook.com (10.167.247.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 12:56:50 +0000
Received: from mkmvskvorts01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 07:56:42 -0500
From: Victor Skvortsov <victor.skvortsov@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>,
 <Zhigang.Luo@amd.com>, <Gavin.Wan@amd.com>
CC: Victor Skvortsov <victor.skvortsov@amd.com>
Subject: [PATCH 8/8] drm/amdgpu: Bump REQ_GPU_INIT_DATA support to V3
Date: Tue, 27 Oct 2026 08:56:13 -0400
Message-ID: <20261027125613.6549-8-victor.skvortsov@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027125613.6549-1-victor.skvortsov@amd.com>
References: <20261027125613.6549-1-victor.skvortsov@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF000392DD:EE_|LV2PR12MB023797:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c520690-61aa-4417-1a24-08df3429c4c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|11063799006|56012099006|261021121427099003|261009223027099003|261021123027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: y9SmOeiAlbQB+2Yd8LvmqQ2Pg+tuRjgVCrPgtn1knJJaISDM9FEB0NrUykqx2zlUHcjoAAzO676rmqFZX4CNeJ9JEHCKOfCOFAeTtoDUxDh1oa/ihgGrs6IVbocNsuTX38YgGDyGcUUCu64JqcMZlDC0RLMjePHezC6Y8UFkhXoffNeSmG2YoBZ9ZBC/GKDVpQQoZH6PpuaRt0DiNdNZ+I83ykEJQhFPyqmPDUdDhhQiKD/r/MAll4q3YGHxdUFxsYuG+wF6/FVh8QvtU5v5wivh/bo0K+SWdvuKL+/vXbV8Gn5aT4W6pgMAFYgzHIoQD4DK8aImCy4oNJPjXjztcjGwy8wqmgyzMB/b+F0/2iVF6paufZj91b45+6CorYPH7kyHmlKHBKzB/orIcVde35SYptsUCVDZDdwSz8RXFhTUkFpTB92FVD1JO9Vn9NsM1eUB3WmfdvoZYHLbqn1fGfFTyPNtUfRb5CO4YjOi1Ak203Y5BME74jH2+ex1l2CST9E1sv2ULx6mveVH/66B7qEP7xCr10NQMZyCHN1PtP9Mv1Tq4/CHYASMsvHDS6Fn7OW8WKax9PXn6Xl2AMkOlZMo3j1ozQYns/kinDiJCo8UUAWA+K+z2Q/9J5AbzzDCjXN3vUwpMF/AobifPIQHM18GbFf8Um3wDbDXuyLhmpi6Py6CEap+i1bTEDMyZjPp9l6cjEokA60FV338hURR9A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(11063799006)(56012099006)(261021121427099003)(261009223027099003)(261021123027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mygBYtC3bAH8OCumeX4G5DdrzZtSr5SsZso8KObTLNQtgIGOCFX8zeA4tzl8yikPxwmMGacCwwu5rN6qRlRYp4tBC57dp+bM3qDfOqz9NFgmlY/EKBDbWrfFVgbvHI1Gyzm/2Y2wNi1zZ3yq6ej2acLGX3iZ2SaRFQIRWr6DetKwSszfMkwK2SY4Xt7Wju7gAdZ8emnlBAcgvPgMaJ5+kp9bHtH6eH6C0VnUuAT60fN+qzLg7ja1rcqS2GQH74hc4qPb99jTQ6BYd1E9raomMzhFdgOOrQUJkWhBnSwf5+3a80jbu/r96P+3l8t178PDOTWXHuLuE7qIlWkhhHsQ91aOJp2W4YFo0UsH8LltswU8F+3zduS9MYr4sEp/1qf6mBFnyT9htHrZsAl9LtnoRT/jzYHJWvKDofSlmEvuoMxX2NTLvSofwZZVCsTTxrQO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 12:56:50.8245 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c520690-61aa-4417-1a24-08df3429c4c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF000392DD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB023797
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Guest REQ_GPU_INIT_DATA must report the highest CRIT_REGION version
support. Indicate V3 is now supported.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index 5ae18c2d71d2..f637a7032de6 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -343,7 +343,7 @@ static int xgpu_nv_release_full_gpu_access(struct amdgpu_device *adev,
 static int xgpu_nv_request_init_data(struct amdgpu_device *adev)
 {
 	return xgpu_nv_send_access_requests_with_param(adev, IDH_REQ_GPU_INIT_DATA,
-			0, GPU_CRIT_REGION_V2, 0);
+			0, GPU_CRIT_REGION_V3, 0);
 }
 
 static int xgpu_nv_request_init_xchg_region(struct amdgpu_device *adev)
-- 
2.34.1

