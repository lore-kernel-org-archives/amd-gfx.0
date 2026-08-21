Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF94BC5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:52:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6843A10F439;
	Fri, 21 Aug 2026 19:52:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w+9+KCQ1";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013000.outbound.protection.outlook.com
 [40.93.201.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9FE310F439
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:52:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lV4Fhp/TqTvOBZmGYnb8aGygRASOI/4SNxrB39P3rPDnxcCFbf+5+yKOopZB3wAACkSlQUIZutD7tlzae7D8QeO4YuVVtnVfOQ+AJVKE06pWXfS9dezUI0OUQQwNY5sZ58jW838zfDHKfCf41kCqR/E5KYvZn9q66xNQlzxC917ZrxD3OUe8Z8i/yJuV1XmRC4pqaukzM7M8f656JQ/pANa6TMzrpxfNfjAFkuhFu+8M1StnL+zcmGw1r4GdKpZ+xqSobYP0jZsNi7vsPazZN4IdM70CY4i9YElsUnOSiP9ntuhBNtBIwFUFwA0WLwh/Sf7DOlZcERj+uWJwl+dDig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RTXN6ckBxNXD/cpaDT4jAbZo+kda2lh5ICqNmkh/pKg=;
 b=Q4X6q1yToDcQLSLoCjbTgI4kZob9umZ+PpladTBc04d6QpCaBcwWp+segSFGXvSUicU+7kvU7Ilx+5pxZ6IofAnJEMm92n33ZnFOcoNtUcPWiC65mUjFevhvEd/pDt0w1p74MvSq5KrCdPyduxBimtNpCQ72EKahOGSPp28LFFNG/jcIjsEvnkps36u0dgWjs1mUtVr8see8MBR6/uV/ojithoLPYlR+y0lzhWlK9KvzOaRhMLBfG0fQuAoCsprQWPqgG0tQBh64DAiJ9RJ0ss4OluNaKncBfwLlfHnOowxJ0ri7xOc8guymj+J7ePLufkA2LLvoHz4jBfrqnyQs6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RTXN6ckBxNXD/cpaDT4jAbZo+kda2lh5ICqNmkh/pKg=;
 b=w+9+KCQ1ZgKjN7GUTUq6uEb4RGT1I5LWXcJ0jA8m10kg/ZXJxpjAg2mYG5vYgob4/1YQLEhhpnVNc/i+1kVQMnyYZ7oojMB7FOpvPsByzNTwfgL7z0qlzyAwxP+ARG/dn+AxmZDyGhBVTgRdzyixl5+kdXHM1i+9y3nzFUq+g1M=
Received: from CH5P222CA0019.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::20)
 by SA1PR12MB8142.namprd12.prod.outlook.com (2603:10b6:806:334::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 19:35:26 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::16) by CH5P222CA0019.outlook.office365.com
 (2603:10b6:610:1ee::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:35:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:26 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:19 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:19 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:19 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Felix Kuehling <felix.kuehling@amd.com>, Mukul Joshi
 <mukul.joshi@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 13/95] drm/amdgpu: Set virtual pod configuration to PSP
Date: Fri, 21 Aug 2026 15:33:36 -0400
Message-ID: <20260821193458.808626-14-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|SA1PR12MB8142:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ba6f173-3b5b-4d99-bd6e-08deffbb59fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|23010399003|1800799024|6133799003|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: pJYk2Rkz3g+cDkPejHRc2Mdi0aXy0DX27sny8OL+/Vd+Oa3wFS2ODEAINZVgnVHkZE0w4faKVhgkZJ0RMf4Z01p4liFfxb0WEYQnk/9KEQ+ciECEc1vxo8clNWta0WRyWpQBsT2ZGLABmSFKxOx9v+gBB4j6KM9pwl5ovKnKxSMULHY8aQ1phYk2goekftTeiMRskq+5MMLMcfQnb5pirO4bagwdYU8TqPDJ5g/3InETYqKtJ24F0XbLk6Xxy2uKqswfSYs0tr+lQ7lrNWuBMKfr+X2d7b4eMnNa63Kn7CfH3hLm6k06YyUKZixFpquAg//cm/tVhXJMNfg72G+pwBdIBBLg/3XAoTXsjmLatfQjByTg966b2nat+Gf7VZroMXRF75wOsd5S8aKdtO6xkHWKaqiuZE2TjuCSx2Yce7NiYlyHpr36WilVn5btFLBXs5wIK4X0/mqu6peK2Q0ASPHlJCUDl9qv6x9eAnE3AX1oBHgUm33l5x7OvvdMdQq/07gzErK1cxgUZyN6A0Ri0IgzActkZon8hIN6UlhhxrJyijlVIvnGtVdkzRM3b9ELBpKFDtupH78E/F3KIo9HrjaBMGItlqrpJ6ePxYLx/lv36YrKtttq9rYtUtTnxrQUHTPaBC/u0HIvj+/pgEF0AXtzcM94XnYD9iTq3AZs4qfJhYdfVkxIWoo6nrMkuYve
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(23010399003)(1800799024)(6133799003)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pxEVvq8AL8/5nVjhZms/qtSvkeZmkyZggSeyqObxZ0aavsrq6rqpjQRcctYC0sSDvO2i0pJy0KTXnDaFDSXBqU5fQ45UgKXZT3aGUO97szQ18VFU5KUzSadIGne4uh0+9PzB1sdU3FldAlPPwf8R4nAA4/9tQN764KSL9jMeYSN2qm257FiHkRH68MevSmAGSidjrafXkbCybgUq1357rNoe7ca3t0vGDy3/Os6t02zPcZEgDkbQfbJuy2/DCrU6mhz9TQpbCDd8BrD/Xz2SYCzMB5ey7ZykGFWKqzHOuebC6A9uMqwV6FsLqJDhfEcJGuoZcTgIvVXU59Trr181zuChEPnPACzGb7NAHaVZV+OzmRNI6hwVP/1TYg7V9G6ONpyZ9meGjomVuG/sXmtWdb/A/JZ5VeHMBYKya9GGpbr9ZHT4XzKUlJZzeuQ/P6wY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:26.6554 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ba6f173-3b5b-4d99-bd6e-08deffbb59fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8142
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

From: Felix Kuehling <felix.kuehling@amd.com>

Set the virtual pod configuration to PSP in the commit store callback.

Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 706e4effb1a8d..b25f61f223ca7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -681,6 +681,7 @@ static ssize_t ualink_vpod_config_commit_store(struct kobject *kobj,
 	struct device *dev = kobj_to_dev(info->kobj.parent);
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
+	int r;
 
 	if (!sysfs_streq(buf, "true"))
 		return -EINVAL;
@@ -689,10 +690,13 @@ static ssize_t ualink_vpod_config_commit_store(struct kobject *kobj,
 		return -EINVAL;
 	}
 
-	/* TODO: instead of just copying the info, call ASP vpod config API
-	 * and query ASP for the updated info
-	 */
-	info->vpod = config->vpod;
+	r = psp_ual_set_vpod_config(&adev->psp, adev->ualink.psp_if_ver,
+				    config);
+	if (r)
+		return r;
+	r = psp_ual_query_info(&adev->psp, adev->ualink.psp_if_ver, info);
+	if (r)
+		return r;
 
 	/* The integrity check makes sure each new GPU is consistent with the
 	 * other GPUs already in the vPod. All known local GPUs can become
-- 
2.55.0

