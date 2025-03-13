Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67CFDC35FF5
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Mar 2025 14:42:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF29B10E8CA;
	Thu, 13 Mar 2025 14:42:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uSr5cMe5";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2069.outbound.protection.outlook.com [40.107.101.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5730010E8DA
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Mar 2025 14:42:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vSieCEWoyt+wOPhSvFSOTSkJCGDMrxrV9M5g8+egOOzXfIKrjKPTN+0L4FL9aM2vdvd4qV3ohw/dGY44/Ts7d2fYgJK8ZwbbJaZTmELlSmHE6c1c1Cfs3q4UMcUnFK/kYwgiA2VLX5qaQ3RSY2dvSI/ttAsB5lbWKbK6gmu2MsOpxf3b3qRCg/0a9AmyTuGFYT/g+1W4mq30iAmPzmh41BZwb5FmArllxFC76rH5z7is1uhHhl3fUXXXnInV5GQyFvm/8++GhztTHJVLFM1XA8F1tuyPBUadtSQ6lfuMYzPMKti7BpO66pPjkyQrZFHVh3Fh2T3lKdjoX/plwS3u8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u0EhQIz4W0DWkwIX/GicJMAJXptGDqbO98sGli8gKYc=;
 b=j3wU+DQKrOkyz4XFXLz5xGjTKVMTtTeH4xU74vl4fzn+HuIWDjqXrCZVZTK0z8a45k7TuiY95NtI+1BgfZJGTBfewio6OWQ6yL6UXkxUVDVqnglzldz7BsBgwfWK7BMyV/syNPgjXpT3iNywBy4Txce9KNvwOpI4NQW80HIbbz2ZHwt9qs2wdbsm76w06BEEyOR9uH65epIAbythFerm3nV9NGEezN+d/fp95ba4gsV8dPjiCKiqXgE8KJN5k3bQzgm882xTUz6ES9InI0nrAM4aZnYkodcfvuzeK+MbuQfgOwAmP1TTFFpZG5/H7Q2+LsWgouLpKSS8aehJQvAcOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0EhQIz4W0DWkwIX/GicJMAJXptGDqbO98sGli8gKYc=;
 b=uSr5cMe5JU48Pkz55L+15y/dVpgfOOzCBCJz5n+TbOuEAg000Xq5axowjuYjZ2845z/S0BiEzEQgUZcj4PaC6pliVkzO/pqHVB016brifKW2fz6yrp9H4L1MsOeBypM9/976Humuxuz10vNEmpTCw+rjLVSJN+NY5G2WlKhgqEU=
Received: from BL1PR13CA0343.namprd13.prod.outlook.com (2603:10b6:208:2c6::18)
 by SA1PR12MB8948.namprd12.prod.outlook.com (2603:10b6:806:38e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 14:41:59 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:208:2c6:cafe::27) by BL1PR13CA0343.outlook.office365.com
 (2603:10b6:208:2c6::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.24 via Frontend Transport; Thu,
 13 Mar 2025 14:41:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8558.0 via Frontend Transport; Thu, 13 Mar 2025 14:41:59 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Mar
 2025 09:41:58 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH 10/11] drm/amdgpu/sdma6: add support for disable_kq
Date: Thu, 13 Mar 2025 10:41:35 -0400
Message-ID: <20250313144136.1117072-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250313144136.1117072-1-alexander.deucher@amd.com>
References: <20250313144136.1117072-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|SA1PR12MB8948:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ef0d098-7a4f-4797-b5b4-08dd623d35ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ju9HkUCYvxURU+quXA6JOTN3qjeUHOjrnZK8PTsKYTPrcDYYFUtNbErCsYYN?=
 =?us-ascii?Q?i/JZjn5APSgadyuiX3ny0+wZJJL5uUsoT5/O4lUNd2shqOL8WZM7yu6WIe7U?=
 =?us-ascii?Q?2JZpv3vDb1UJtLkY+ZQ5h5wK282ZyZZ/xHxzoD3DB4MgV2qJ9j5KRXMHWHhT?=
 =?us-ascii?Q?4sJekW+6iB19WxUGAV8yiaAPGgUF8QY5K0Ow3NntAMAec28GWcr53GoggSrb?=
 =?us-ascii?Q?+/KKauUAb0MpKWh8+gXXzOvDdB0gXJVpe1kZVGdtTyBYsqIsca+OHD8zu8t0?=
 =?us-ascii?Q?evIheNwS5xy985/vqj0aG/YUGcdy/zzT2PJFR8MYoocYvg75F2qhhprOKhUS?=
 =?us-ascii?Q?a4FgRuhlzxMdUv/n6m3CGnx50+hQNfB0TqzUvKqya81U9DYLSOYKQsxBATiO?=
 =?us-ascii?Q?HYTEHzz3CsDasbUyAGrygbVIR5bA9XAQlEPoPsOddw6D9o55mup8MSYwwnzP?=
 =?us-ascii?Q?Fz/yy7nHIcLWlFqgByCPcROSMUO8KBUOF3uxOtjIK2IbI/M9NcOY0GlCnh4R?=
 =?us-ascii?Q?3HG5VirQoioDCfC7aSpeRNV8n2njKgrrtyl3Ixw0HiIToe+iDFeZgHqFbGKH?=
 =?us-ascii?Q?GNpqkHVdIc3T0N31kJeWhmQeaP5xdYsNHyphA/EWyMq9vd4/HfTXxYD47M1V?=
 =?us-ascii?Q?JQ6TPS6S1ZnCYRb20QZm69VfLAGbwT6krUmaPJ4IXxBRFbx/OLbiSWp49sA9?=
 =?us-ascii?Q?N34/WG5Gt5RG9TMNRGpE99/TVd0zQXCj5WWsx/41oD1xeGZJUbio6NtMZgT9?=
 =?us-ascii?Q?B3Ipo4ybANGy1cEkJfAcne4LEGP4E3cUk1wdT+/MoXsV73uUrkKRkXDAyMdL?=
 =?us-ascii?Q?EvsZBINrDX4O6xQzGMxVdlp8/9ibQ1SVHiZG00Sad6ihNdXjPYy1r95xeYTD?=
 =?us-ascii?Q?A0KL/CW7phR3ZdAlMFDfoaNfiN9n7AyYduJsBMM2had9Mq5dG0V5UwdyXzh9?=
 =?us-ascii?Q?jp4aAF52wdQ9WnAWiOP62wVfnGpCA89TPhzKDmTvGGP0H0NYuwYC5jKzME2l?=
 =?us-ascii?Q?3GBbI7m7lJLFq9fMrKOmS3PSzQDW64mdOOp/B63fyGR01b19iml2ywwwwCvT?=
 =?us-ascii?Q?XKUM72gYAEpFRQ2CFX0IhH+WSGbV40QWrMFIKwxooFVEf/NcqpeihGt0ih/T?=
 =?us-ascii?Q?Fw9mQjvdw5Z49LWISBnphUpcHBFFO3qyTOgF9udq/qlxuVrVovYlxfzxxHWh?=
 =?us-ascii?Q?ttaD/xgasVXN/RXg5tEoHoPYeaSYE+Fm7fu6v5orI2vmFtbE2wMXJmgzZp7l?=
 =?us-ascii?Q?5qQu83qr4cNkN747FHGlxA3BizmEqG3j6mNksSUE7nCoy6Is8WG1IHG3/CHk?=
 =?us-ascii?Q?MRXWYYis4IlhbUJ/4yzU1G22cnoBOwLNA6yO8QNFtHXGRgeD4yXf9KTqTzTk?=
 =?us-ascii?Q?oWTkG1ReJgrvtIlbimRiZACZ9BBCyxVQwScUnnJH5KhyYuvZPcJcM75mMDg1?=
 =?us-ascii?Q?4O3rWCgpu9ZwYvjKw5t5EUkvjcjApE09rxE8XmeoBTB+ue3qHInLkQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 14:41:59.4487 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ef0d098-7a4f-4797-b5b4-08dd623d35ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8948
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

When the parameter is set, disable user submissions
to kernel queues.

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 3aa4fec4d9e4a..bcc72737f8084 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1304,6 +1304,9 @@ static int sdma_v6_0_early_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
+	if (amdgpu_disable_kq == 1)
+		adev->sdma.no_user_submission = true;
+
 	r = amdgpu_sdma_init_microcode(adev, 0, true);
 	if (r)
 		return r;
@@ -1338,6 +1341,7 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 		ring->ring_obj = NULL;
 		ring->use_doorbell = true;
 		ring->me = i;
+		ring->no_user_submission = adev->sdma.no_user_submission;
 
 		DRM_DEBUG("SDMA %d use_doorbell being set to: [%s]\n", i,
 				ring->use_doorbell?"true":"false");
-- 
2.48.1

