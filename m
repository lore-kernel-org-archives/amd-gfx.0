Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F135FC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 19:45:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EE71112D20;
	Mon, 22 Apr 2024 19:45:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tKXNmbPK";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2054.outbound.protection.outlook.com [40.107.96.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EA5D112D20
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 19:45:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bUohVW+t+1Lv4xSjG50FTats/1P7tNtjRtXaq7NloustW8nULuX9+GdBwlnZKsqgI4M76Bp+vG1qqQeW9R/mRnPQSXZZgVVzJWTwj6EJDE+DG4arCD3ed3InJDDZ6ZHI+XD90UPq9Iik2xa56QE9bwpA6BwkfVljkUHYQl9kbY2wd1Sw17R4PtM1+HF5kQiOyKNhFbhUi4pzbg0IaONswcdKhuuG5D1FQVuSv1wqFaPmFuHPojwV179AnYtE+i58VdUCXMM7sxvaf2ESem8Un0I0L2WS2k9XXiklJZRpY5cXVQtnuUPTIWRJZbBt5x7Y0eP+sFiKpTzVpvNr7BUPRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHFzxLEeqq8ULcTsMIV9j2fZsIjX7KjWdQuKT6g+c7o=;
 b=ECCUWKw2ZYKiZd8fttXSSGndL0A2nFzf6B/a2GThF/c8+wWYNRabYhNhAO49Y67458JtgDLGDGBIWxCAqpuph89DV9ucLXhnQO+pomhOfq+0XRNn8Kq+ItdYVgVZjhDFVcJuVe2ix7p6VrHVD9cDuKc8OhzTDjr5RBejAMu58bdeecYvjQQldeN74Y0jbodabsDyl0RN/uBmnzwpov0VXpm2mWSZf8KJVsUydJxPWs9PNE5ihdWhF6CfurtUFOc6pudx7XzdvOHKAhpxpVVFTPTkP5fSiQKW+MUOsGrRPLrYN9faJhLVOVfnEM+dxe2CepS4HSbantt8x/CA+ZDO1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHFzxLEeqq8ULcTsMIV9j2fZsIjX7KjWdQuKT6g+c7o=;
 b=tKXNmbPK7mzJ1lSoemNc2+iL/Vk9cyXyhwjy7t+1KHv4rDqwyMR1w3AjdD9DWb/oNziY5vL9ER6MRY94es+y0s3+vgNqrw/LBGwlcEWVWsinTAw5dMzee0d6M1QobG/vJ0FtwzGhxKXRg/86G7PZHJF3SC2P+5L8zpCRzx+eZto=
Received: from MW4P223CA0005.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::10)
 by IA0PR12MB8302.namprd12.prod.outlook.com (2603:10b6:208:40f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 19:45:14 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:303:80:cafe::bd) by MW4P223CA0005.outlook.office365.com
 (2603:10b6:303:80::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Mon, 22 Apr 2024 19:45:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Mon, 22 Apr 2024 19:45:14 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 14:45:13 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>, Yunxiang Li
 <Yunxiang.Li@amd.com>
Subject: [PATCH] drm/amdgpu: Add reset_context flag for host FLR
Date: Mon, 22 Apr 2024 15:44:45 -0400
Message-ID: <20240422194445.26127-1-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|IA0PR12MB8302:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c7c9eab-77e7-498f-245e-08dc6304bae7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?F8aOrJ43DgMD+EIP5Qcp00tBTt3Ov9qpxNUcA4uweZMWnbnf8imbtJgqEZ0/?=
 =?us-ascii?Q?wql3uV5nhY/po2DlC7nMvelxrRIy+4ZhePLAmQ8W5qasgKgIC3cBFrNuIxOI?=
 =?us-ascii?Q?HgYXDptQsWjsrFIEEXL8NhqHwOJY3+HoeBO2CIjY/93X1ZEjCTvxQPvgFYWi?=
 =?us-ascii?Q?tcLEvNsDZxkioLCQ+YPYS+M7Nd2Dl3bbQpMALne3yDTXC6lMeQER/Z24dlaw?=
 =?us-ascii?Q?TacmARL7RAh/w5lyHYG8q7ERORL044Ed01McW+zBIim0ogZBA4YLkdSoCLhh?=
 =?us-ascii?Q?uny1IwElTu9P/uNZB3/PMNAS+d+26lxB9tZfKE/MRaPpVIL43JAbPIHgEfZP?=
 =?us-ascii?Q?HoZXu0Gfh2Fc9fTEqy6D03m/joxEGXwBJFZIMHLz1dbdVrzYn9mX6wVniaTh?=
 =?us-ascii?Q?X/G+9WgVMNxUaDQR7f2fKw+BKNgwSmmn46oHPm80yqbEICRQYl1GtIWAqKcf?=
 =?us-ascii?Q?ixyIDPjAilEhgNtu5HnqqU0HOeixXEDUoB/3RpcWTZ5p8ActE3tUOhj/Y1mf?=
 =?us-ascii?Q?H58FlaIQJiNllA3+tBHeR1DQbL5oR12zwmYvHLR8xyTVIjhm1fbeKjlVUg44?=
 =?us-ascii?Q?TfQBY/VPUSCqrSV693vbblg5mv7dzbFRbZ1crSxrfdeCEPHW1Ov5EOJA/U/t?=
 =?us-ascii?Q?pgg3qlWhlPcJQh3Ng4mz1g8fMpj1rM7pFjLMVrwE6VketLF15Y0RvhwFNT4N?=
 =?us-ascii?Q?AjgnBx9adgj4zyPoBtUq52NfkYmgf4Fe6u9WvmGXvLW2QsvxkejUD+IN0Ofm?=
 =?us-ascii?Q?zIKkkPuh3YZxAy+NjRTGPlWbqJ+8HEcSqK+Vu058EzorKHaeu78iti4MF8LC?=
 =?us-ascii?Q?6N3gMr3ckICQgSn9t4o0G8Fw7XEcIJpsF6EzEab5UdNfcQY0A66fRI/+nCQA?=
 =?us-ascii?Q?9BG4yhbSj4D7AZqPgMrRi4wyW3b5Upad3Vm+Ao99xSsKH5VTiUvxxZqz83+d?=
 =?us-ascii?Q?DsovmZMvjQiolN+SF8ddv+IomhzykCxqIoP/bHtZLGFfdxYcMDOCOZfRY0Op?=
 =?us-ascii?Q?FNxMgl9ryGwJobjtNBXUbiypKQnRibRXi4y/BzBE+CMeqcupH+LN47EAz0OI?=
 =?us-ascii?Q?0PC8jqivV/tmHFaeG5hufd7BSi/vAmBD08DrrxbWXSzEMKyGyIrun5s+R65r?=
 =?us-ascii?Q?W3TfpKod/UXlJHv1fKrjRVeTWdfqwX7EnuHVFjWEQG2anZcY0F/Ui6Z6Yv4E?=
 =?us-ascii?Q?vuT+URohGpWf84e7O49ZImMV/UPM2hz0ykst1d80wacJQnmkuYlLo6OXk9Ux?=
 =?us-ascii?Q?YxtapwbYb/k2wzZfJVUTc0jPB2oPHRy2JxjHy78aI50JyTI0b6zLQ4BigU0d?=
 =?us-ascii?Q?6VWW+gnS/0adsFwRDIno/SkVyIp1EbeC/hTwHAuANtL9ceOORGO09uztkTKQ?=
 =?us-ascii?Q?ZvlUV0E=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 19:45:14.5090 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c7c9eab-77e7-498f-245e-08dc6304bae7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8302
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h  | 1 +
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      | 1 +
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      | 1 +
 drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c      | 1 +
 5 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f8a34db5d9e3..ebf2042f3fb7 100644
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
+		from_hypervisor = test_bit(AMDGPU_HOST_FLR, &reset_context.flags);
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

