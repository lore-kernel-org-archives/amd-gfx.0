Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D27F2C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 20:16:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4692D112D3E;
	Mon, 22 Apr 2024 20:16:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kk8ipcYx";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2078.outbound.protection.outlook.com [40.107.101.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66E87112D3E
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 20:16:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EA3gMAz7jHmCNKkbO4P+d3EGuJ6gaI2ul8Z5ky6UBr/WPWREhu6hWfkgdUYvbRnMb4o8ZkkIdRleMTb9PIJAE3ryLpX9AXX/bzAne0yNEyY2Cq4gJc+P7YosggP4sV1FvhbCe8p2PPhz1pxiP03GCfvK3tZbGH4t3dXk/5GABOp/psB12fT8JHLV8rQ2ZEm7nqUFNIdmtgRx/DP0HdN9caqHvNBefupHr9l2rmtMhGBl3Se67iDexIHWhIBFOd6VGNk0XcZHYaH/F0o59KRn/y7fYZLTfQZCHPvcauSo3/hOs5lVEf9wq530kk0jGbrtLiw3QF+ydy7jnG426wQ2Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1JmhukDc+DgkqZsBB05VcBisPbn9Ze+wR5MOXtRZ58=;
 b=AXfUZhdul4v1WFDanMistVbyVIqpl7+CwBZKDozJ98kCOqhuT4Lkgv0klclITOolKZhT/kJRfToh55+MtSz50mHtNBm9rRlSTvE0/zMSX7xCrQnsfSaz9lnggDtpHEFznsVL/ktVJ0bravYLUN5TNO7qMj3FceBAaG/diW+djfSwYCnuJqhEDkSmwsJlP7F2dwaoiNvvPteSGBJZqrV/OjmIi9rD3QJnq8iKEasNjImgO7sBAVSzhP+iduZU4uka+0Bs2i8joV9ApiDEH89XH9uZBMSlTBMwXjZ/Ubrfh48Rhd48o9wwbsgYy2TReWIBGWsFOLsCZC3DZ/FDlDrz0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1JmhukDc+DgkqZsBB05VcBisPbn9Ze+wR5MOXtRZ58=;
 b=kk8ipcYxtW/EQP+g+xXhd1pzto9KRxuIuPqd4b4i10IKBJ+NQSfJfiHfVkyb90UWwtiZ62ejnPxb8PaA5gqzCahgVwD9090dwZf1/wZtq2ng7i2ilR1l8wmo1XawKgKiqxbJfOfSJUZM+jcnccNK0WDtblAwQ2lgtHTOiJpedTQ=
Received: from MN2PR05CA0053.namprd05.prod.outlook.com (2603:10b6:208:236::22)
 by BL3PR12MB6403.namprd12.prod.outlook.com (2603:10b6:208:3b3::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 20:16:18 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:208:236:cafe::e5) by MN2PR05CA0053.outlook.office365.com
 (2603:10b6:208:236::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.20 via Frontend
 Transport; Mon, 22 Apr 2024 20:16:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 20:16:17 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 15:16:16 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>, Yunxiang Li
 <Yunxiang.Li@amd.com>
Subject: [PATCH v2] drm/amdgpu: Add reset_context flag for host FLR
Date: Mon, 22 Apr 2024 16:15:51 -0400
Message-ID: <20240422201551.27186-1-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|BL3PR12MB6403:EE_
X-MS-Office365-Filtering-Correlation-Id: 8616c82b-d7dd-4584-b792-08dc63091165
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZmRsIW2StDV8+U/aMFWRKV0zfjTdhnid9valviZJSxZtiB7AUZgC+elixrNP?=
 =?us-ascii?Q?8ShBvmK8KglZyYZQdaLlM6ctb0P4GMt1YjC8cbR0HDW8Y7jA7Z7dLxcnYFN5?=
 =?us-ascii?Q?pRLr+f/PgucpK7Is2gP2Z58zyKDNCTeIzkb3U0ZlRwR++Uf7dBrRWtrcNdwS?=
 =?us-ascii?Q?kfVPWa/jXVjIefiLB7KvGNo5M9BquEUbUEjTDprAWT/A0feIZcME/7ZDSevG?=
 =?us-ascii?Q?g5kGCJ+hKnVxYtwRoNaFlHzWh5ekJfhM5OekRJiZBinOL48aiWjn4OIoII+V?=
 =?us-ascii?Q?PZdTeo3PL57wyr89ylGPedu61wcFXdEhTws+WUSyhll6QJSL7VjUlDTH9MxY?=
 =?us-ascii?Q?dP68NBPcp9MG5ArTFeFlHdZW+mQoZZpLy+chBwAEd6Iy6COdMpoIZk7QX9za?=
 =?us-ascii?Q?+H5QgdLGe4DpEqnPoJedjOGBSzfbL0WxJExKUZcDEANAs+w31QSDUuQrn3ce?=
 =?us-ascii?Q?fw0JRD2B1w5myT8eoCkyI6Gy6rClXM+0PMTiF/M7h9ImDhRr2Oh3IAJdZkDW?=
 =?us-ascii?Q?HRj1JvwpoDocPFb5ENLNoQdOXk/E42oSKw8MUdK1bV8RCnbTK5+P0YSSEbTx?=
 =?us-ascii?Q?aRLdTBd77sLR+S4h8Wq1GxVemiSjS2DIRKMyEl/m3fcEvYzadxV968+PkcyF?=
 =?us-ascii?Q?1eH1jwX8fedk8TllmF2R+2J5WVCsBeNNPvddLmuEG3GI414J/LMcqnxRLCjc?=
 =?us-ascii?Q?fpySG/iivfQ4QGOuGPuKK+sPI3YHnc/RPhozv/ydTii4JzFDPSfLxs+jol5a?=
 =?us-ascii?Q?e3150+ZD5we7c8pOjkUHCYs7tSt6pmMmoqD1XImE8NcFXIKp1lUonnPbZkYv?=
 =?us-ascii?Q?tCl3g5v1hEL+FxqdQDKtbbRUvgu+VelerJi9AEwHhPgG6Mvy/xJ947H+4BEG?=
 =?us-ascii?Q?Fv5VfvGumyJQzyRygtCgjCwQKH4EBVMZ4jWkcE3tkfOSN4qTsmIvLcdEMKzR?=
 =?us-ascii?Q?fVQ28NcnZELxbsxwZ3gCAa7zs8BZMvJF/a9J/y1YvWpz7LXinmDArnPkI45G?=
 =?us-ascii?Q?8pTxmu6iWnuCw3Nv1e1rkCUiQNWqp0j2PlqlB4bPkQDmSF8lMuS8bYi5kAlL?=
 =?us-ascii?Q?kWgYBvof6+m5z91AwElS5e61IOEj/CMyGjl3Ycg8kRRYtd7QksmFc8dmkzK/?=
 =?us-ascii?Q?kRXWGn2G3lDDe/d5gRlmDH5Qg3NelWEKZr8D0cjYTHZ9BeNApA11JpgtPXz7?=
 =?us-ascii?Q?bxoofq4Hjb4COYZYh+e5CjgYU4KEbIq0nMlEWuz+MtmygJQ8Aix3f1l2wkkP?=
 =?us-ascii?Q?83lIYSYNzpN3s2mYlretkd+UoyouK99Gqm0wTz5G+MCVrKAV0C7vnl/ODnD7?=
 =?us-ascii?Q?g6Ca6sBV1bheeym7qNn5zgW6AQfQ+XzgheYr0y3InewZ4B2gE4iaLZh++jhS?=
 =?us-ascii?Q?KIejF2E=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 20:16:17.6877 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8616c82b-d7dd-4584-b792-08dc63091165
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6403
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

Using the job pointer to check if the FLR comes from the host is wrong,
there are other reset triggers that pass NULL for job. So add a flag
explicitly for host triggered reset.

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
---
v2: fix typo

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h  | 1 +
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      | 1 +
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      | 1 +
 drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c      | 1 +
 5 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f8a34db5d9e3..67da24e9f0a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5678,6 +5678,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	int i, r = 0;
 	bool need_emergency_restart = false;
 	bool audio_suspended = false;
+	bool from_hypervisor = false;
 
 	/*
 	 * Special case: RAS triggered and full reset isn't supported
@@ -5825,7 +5826,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	/* Actual ASIC resets if needed.*/
 	/* Host driver will handle XGMI hive reset for SRIOV */
 	if (amdgpu_sriov_vf(adev)) {
-		r = amdgpu_device_reset_sriov(adev, job ? false : true);
+		from_hypervisor = test_bit(AMDGPU_HOST_FLR, &reset_context->flags);
+		r = amdgpu_device_reset_sriov(adev, from_hypervisor);
 		if (r)
 			adev->asic_reset_res = r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
index b11d190ece53..5a9cc043b858 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -33,6 +33,7 @@ enum AMDGPU_RESET_FLAGS {
 	AMDGPU_NEED_FULL_RESET = 0,
 	AMDGPU_SKIP_HW_RESET = 1,
 	AMDGPU_SKIP_COREDUMP = 2,
+	AMDGPU_HOST_FLR = 3,
 };
 
 struct amdgpu_reset_context {
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index 0c7275bca8f7..7275b5ca6f93 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -292,6 +292,7 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
 		reset_context.method = AMD_RESET_METHOD_NONE;
 		reset_context.reset_req_dev = adev;
 		clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
+		set_bit(AMDGPU_HOST_FLR, &reset_context.flags);
 
 		amdgpu_device_gpu_recover(adev, NULL, &reset_context);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index aba00d961627..811fe7a6e4fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -328,6 +328,7 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
 		reset_context.method = AMD_RESET_METHOD_NONE;
 		reset_context.reset_req_dev = adev;
 		clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
+		set_bit(AMDGPU_HOST_FLR, &reset_context.flags);
 
 		amdgpu_device_gpu_recover(adev, NULL, &reset_context);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
index 59f53c743362..95c225083939 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
@@ -529,6 +529,7 @@ static void xgpu_vi_mailbox_flr_work(struct work_struct *work)
 		reset_context.method = AMD_RESET_METHOD_NONE;
 		reset_context.reset_req_dev = adev;
 		clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
+		set_bit(AMDGPU_HOST_FLR, &reset_context.flags);
 
 		amdgpu_device_gpu_recover(adev, NULL, &reset_context);
 	}
-- 
2.34.1

