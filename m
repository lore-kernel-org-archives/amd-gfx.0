Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CDB9C5DF93
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:07:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D0B710F355;
	Fri, 21 Aug 2026 16:07:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fwcggATC";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012028.outbound.protection.outlook.com
 [40.93.195.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74C5A10F358
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:07:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IW9lSTOt/3/uaOdz0GmR5924fnO33s3ICQIMvljCBGO5PO1DJ57zR28qIKekkDTPh9uY+hkOAhHRvt0JSGBdtDNfDUODr+Os7gX7e3piEwDLozxXC1lnf8KeKR89Vukk5kmaV9R/DmHjmbKSx9iGjlzZ7/0j/Uc2BTUfZI+9CEOgVeP1VTSqTrS2GOnfneknRDFHoJE9pwSEfLh5UMWHN/ohNA3vS0VNqeYmbmKwX48xnaMeqvSP37SEaTR3gZHphh7KDvNGxuGFof2rIiSdGFrlWQpNXtNmFuqqcGQpcEckDICpUebFh4B+cJdfldkXejd0zcjCcNq0ZoryhfMK3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sF1nVM1n7n6KkGbuKdItrXKIEz70jOvydmVx3FPUzW0=;
 b=cSxzIlHQJR6KhExAS09dv68FbE23791pRPycORCr8Cicmv68Vaq1vs27hUZTypW+NrU8mWRYRNis1s3JlVnV5vXByYO9P/IlWcCpCPhCSr5ekhJ9qMRW1VeMcrcqrZm7su+God7+DhXyYiPx274HCFG2Wu2rirTz1JLBjNQVFUoGqdgzUhp3MmeHzWkGOYWouIoEw6AWQZU5m6LbCuVOrQtwBr6lxn6m0qw+mtK8BpqTOEubktfUmIYgV+QvajOKgEVPAsse+U2kxHfIrN6wacIaxF7VzX9BYLtCZTVNwf9DDj28u4s1Odf9pW6FkY5o7FvZtJe+5lG2GIWtC66WJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sF1nVM1n7n6KkGbuKdItrXKIEz70jOvydmVx3FPUzW0=;
 b=fwcggATC5zGctiwl6Kej159MlH/+BG5++b2iwBWKlUZSNZzyaldikg5lKJHEhPGSK8i4DzT2Z01uYOk4VFbIFRY4ZFcnmlQ6+BbK1wLJ37y1tuz6xmmT8KAg3HqeIi++HOerbt8b3F2SmiFRcUPQzriWFoyFnASwsa8uGmMmNCA=
Received: from BY3PR04CA0023.namprd04.prod.outlook.com (2603:10b6:a03:217::28)
 by IA1PR12MB7735.namprd12.prod.outlook.com (2603:10b6:208:421::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 16:07:30 +0000
Received: from CO1PEPF00012E64.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::6f) by BY3PR04CA0023.outlook.office365.com
 (2603:10b6:a03:217::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Fri,
 21 Aug 2026 16:07:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E64.mail.protection.outlook.com (10.167.249.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:07:29 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:07:28 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:07:27 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shiwu Zhang <shiwu.zhang@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 09/15] drm/amdgpu: add mec FW support for silicon rev 0
Date: Fri, 21 Aug 2026 12:07:04 -0400
Message-ID: <20260821160710.752459-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821160710.752459-1-alexander.deucher@amd.com>
References: <20260821160710.752459-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E64:EE_|IA1PR12MB7735:EE_
X-MS-Office365-Filtering-Correlation-Id: bf51ee98-1857-4755-1e22-08deff9e4d25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 7jbR+vsfFUCAFD6aSWF9blu1wyDmUZ/ervtlPsxEn09S9r9OIBoqpLN3GbA/OveLWqpj9KZiFBWY6dME5OiHS4k4YVqIWDwTs1HWHNmWvGNvJlHT1BzYuo7nCTiCIxRTlSYQCzZmeClP/PA5cx06gFZRZVRhyDIvVNQOWuuLLbKe/ZKXbOLfJ5bAJeY3f+/Vpu+LhQr4d9yrkWPX9s8VTa+bj9KTT7XgJkJ6k4PVKD5gI5xSey4E3DfwcUZgWlUSvb2Frdk3kKReJEp0dLinfBuXu4Ok8PT6k4HUCNgaC/g0S/wdg4x7I1PaOo6Q2+OIWi/OIwqzq7CtG1FfV7MFkHniRWIgt70SKCNdOu/WaPnMvLCTvaN805a2vd6VaKibJAHoah28b5g88sQ14ynQ0GqDebnI+KZkxB07AygJOg7G+OfXl7JKrnEADlUrW/UB1+LyieERU1TbUNaFfmWHg3//5PUIc78b3ViWWN2jC7htI4gkjy1d3e9hE/Mg+84JLQATsdR7UHioHVtIpPL/3Gk6M/tsz2QNAEVZiFKQIe032gdSzlMExOgQ/PuTGkqEMsxSrSIgNkFvxd2HvCDuMlBTXKy9MDm6QJARavfiLT7ltNix9+irXLQUW7W2Jk5IiAOZKa6EhLAYziywhjOOHKoPLA6uMkX7Ok6T53eCYd/nt5UUvdXbCLuV4IfeAj2qkdAhss5e4AjNzox3oUdZ2g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: f8v9M31576GMZTq6D3MwriLOgrJMEyuMp2nWjhObkZac27A3pAZBdJMXvCz8StDkEEjAyDrDd/mAWkdKOj6SIsb09NfM+v8HcJlpqLu39kSdR41VQcjaa8e3w4ypc6Dc1aEKryZeLWhTtVkdHfC6MQj6awDUT8HP33tBJdQtjPO10Bgv7ch0U+kaN0DFA3ibm9Cgv1hqUXxSMBynH8o/gmPCMD7kPkJed9VWLN3sC61GsWBcftexrdP/n+bPZ0LzlgREc8xNSqXbh5H/aKpESCIeEAcQnXNu6gh2yKu54Ct44RGzZJXif42LKD9ZelZEtm7hvZ3xWCk6MJezZXY5/YZS0sT7g2mgZUT3tbR2r3dhtZ20u+I6VB6CetWB1lBg8vGCjycqJfIl8kAjXm4QFnwlEpC8ppA314XfN0UzwVnBStYv8SfbFu6Up+vwcbrf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:07:29.6047 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf51ee98-1857-4755-1e22-08deff9e4d25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E64.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7735
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

From: Shiwu Zhang <shiwu.zhang@amd.com>

MEC will have the specific FW binary for silicon rev 0.

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 606106ddf99dc..41b92d0685178 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -549,9 +549,15 @@ static int gfx_v12_1_init_microcode(struct amdgpu_device *adev)
 			goto out;
 	}
 
-	err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
-				   AMDGPU_UCODE_REQUIRED,
-				   "amdgpu/%s_mec.bin", ucode_prefix);
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 1, 0) &&
+	    adev->rev_id == 0)
+		err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
+					   AMDGPU_UCODE_REQUIRED,
+					   "amdgpu/%s_mec_1.bin", ucode_prefix);
+	else
+		err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
+					   AMDGPU_UCODE_REQUIRED,
+					   "amdgpu/%s_mec.bin", ucode_prefix);
 	if (err)
 		goto out;
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_RS64_MEC);
-- 
2.55.0

