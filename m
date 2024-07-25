Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CDE0C3DA64
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 15:01:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E98B210E860;
	Thu, 25 Jul 2024 15:01:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4QivjE5x";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5547F10E867
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 15:01:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ejWhfA5u5DMBOz3S/n+RA6pZf/IMY19xCbjS/gIvl/F+Ijj0xKGbev05y7OpOF5SFH37W1tAvXitMua8O3zhw94suMhGP/sBu6ANeTL34QsRASiyvplqOnMKRjYsKVfB+YzfCzeU70UpXUWFpVWbVTOyAy1G2F8GUwtaQkTfq5xKsXbz2nyMiKogjKw27j3BOLdjfeL8HXOCgu+5jrupVp98ifXXw+uFjLKy2mwI0+piGeNXiC1FqbJbcGYCRtw4m2aX5Jk4z1VMxX7MwJtcicBgf/0aNrnRsgZpiTU0QqnewmMJ4/GPY63jBxOlpW1QZNRQTCOw9/KzyZXZnQAJ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zXCqwnLN2aPtWWyHfoXCR4uj+TN9STmePLkAL3oSzOo=;
 b=xhTXLmlVwuGVAvFrv9kgB+iff31WKAO9WhM97KXoywcfcHUuBOCDIqj79YCsSgCMyk+qdKFg+bErJ/CZcou+2ApMwqmJ53AtMpz9o0moSi/Xztd8iIGriRrnsrnlhIIDjIqgCEtvoCUsMcsPRcrcd5nkN1FAPdSDzDVxoKd+zuum14wg0Fang9a/JP7q3rZLS93Qhs+GXMDWRMqu8Ckt+xrFGoDD7llzu0o/u3RPles/WANGXxOyzNtn7kFk7sRjoSUkQMQlFN7TJ7jPTo6rlRGNSqplIY2SGmWgev5wdOJ3KXEwv+Z22PhTWwKC4c1Qq06YJPKr8ryT+Y8z+Plpag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXCqwnLN2aPtWWyHfoXCR4uj+TN9STmePLkAL3oSzOo=;
 b=4QivjE5xkGG1nF/d1j+gFzdlQnf8DWq/EsfElw4CGyz2JC7IdUkelT0jRtPxe19IWw4roC+0WyMS2rKxTU7dbV/vhuiK3H1npcjOBTfp5GtGUhQ8opgftkCMiDkROw0l8xY5+m8p/38DaSXphqXkvLV2EnchsujGG9KK8IrKXtY=
Received: from CYZPR10CA0008.namprd10.prod.outlook.com (2603:10b6:930:8a::18)
 by DM6PR12MB4316.namprd12.prod.outlook.com (2603:10b6:5:21a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.30; Thu, 25 Jul
 2024 15:01:29 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:8a:cafe::c3) by CYZPR10CA0008.outlook.office365.com
 (2603:10b6:930:8a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29 via Frontend
 Transport; Thu, 25 Jul 2024 15:01:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 15:01:29 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 10:01:28 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 37/53] drm/amdgpu/gfx9: per queue reset only on bare metal
Date: Thu, 25 Jul 2024 11:00:39 -0400
Message-ID: <20240725150055.1991893-38-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725150055.1991893-1-alexander.deucher@amd.com>
References: <20240725150055.1991893-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|DM6PR12MB4316:EE_
X-MS-Office365-Filtering-Correlation-Id: d8554395-4240-451f-ac21-08dcacbaa9ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZciskFsKpZdtfqT5PLKVeqtS3Uc1e5LFqRdkCBygA5QS09KoiZNVCBf/+fZt?=
 =?us-ascii?Q?9vkg4b08oxB6x99lh+8yo8Vo+fG7QfRfq7jd5ZgNYDpfMQqUGGMhrFvSoAK6?=
 =?us-ascii?Q?RSyHJ9N9siRzan8uE4lx8F6vTsMr++COT8/1NhGnib4+uZXo3ri2bge2Sm2u?=
 =?us-ascii?Q?Gx7ZGXJ5HyaraQTs0VABsMMXv+S68xzSds59Y6ee0wYDM0q7uU4qs5dKm+u0?=
 =?us-ascii?Q?OrSLjKXlVtfcf1+c/10ISSsNKjj6JSmjB87/K74uA7UIJSl03dYFtfKMQ0OV?=
 =?us-ascii?Q?r4tqw9M8rYPr/uVPFNKvTfMJqvUOy6GeVSxP+PJb9c2gdtleg54VYUfFq75s?=
 =?us-ascii?Q?4AlGUsiJnbWqWpRJq3GimdtkmCUqXvcio+8uRFaiolChZY23a2d2YkZ9vP6M?=
 =?us-ascii?Q?kB/aiEEpitir7JA2HyMKGJwXrqWW+YB2dzS0y/+hGRqS2cvQAufBhrW8xMnS?=
 =?us-ascii?Q?Njm1dD03H8A5uboMTfot8YhuBBbIm/z7KtSxdnWWRJEo76tOhPNC9yqrs2Jx?=
 =?us-ascii?Q?s3PQiif+1bToTOkMNJVRUihtTpK1+1Ro5mFaFnsCSBIRBAu511YFus/Lc/Ey?=
 =?us-ascii?Q?zDqDdFHIoX0ezvu+liIAsFyc2bdFPJkQqUIO5xUub1Unvv4oedsfJemu7bFW?=
 =?us-ascii?Q?vZvLtv+G0G4Rhi7AIsT6z+qsqWjycDF37W/hPkDuwRb/+JovtmdXNow1Gjta?=
 =?us-ascii?Q?rFh//cn3eOc6QuhV5NENQqQOVH/gWgsIAQKMQVGdht9311LxdBcoDHGGviTP?=
 =?us-ascii?Q?4PIi544kuqbnQhUx/hfYOGTwWMaeYiIbX/nwtXBdlNmHVEpxuzo09R7/sQsT?=
 =?us-ascii?Q?x6K9BDIdChFnLmcEvpEzchfH9DwZnbQIXbvT2WAXrAjzLH1Y+TVNqdbzUNxZ?=
 =?us-ascii?Q?NnwTYnqdh7EPrKyFVbQ5xzNHBNL5OzgOena6bkfHdqA5G2weYmE5YPa5kEoD?=
 =?us-ascii?Q?WKp7Otkv09jGDu/RSmdBdy0pa92i1FnWgdXGDCX6KBj+GQLoAIYLQsqyfTXy?=
 =?us-ascii?Q?8oB0O3E7M0ergB4TZd473gx0ZXUQm+oJnlhsVuOJcgfyN+emHL2OizXhryvc?=
 =?us-ascii?Q?luCBlllaKztX4FeFo5h1hslHqyDkrj96ys0iiRDc+7/KOcDiUuhMoVmTY7GD?=
 =?us-ascii?Q?msuBLPy15+3+9nw5O/Gqehid+U+3sx0hTM5DZY8OKhBZxXzZqfl6RPF6SfqG?=
 =?us-ascii?Q?+2KLgLf3+vKGsOW2EpdBUB0zoOTRaswBV1pgcBMFJ5bDF3jjaeV/kPeTrYDS?=
 =?us-ascii?Q?Nm9fXG3o/5MqhQ6t/SGoeVomVwGIfNakDnPID8aB1/sVpqDFczdf4DghPquM?=
 =?us-ascii?Q?A6HHsiSx+OsEA8NMyGMgXPZg4M6GOUAITTBMf4SQD5Kd0oUdOxBHDv6rPoWJ?=
 =?us-ascii?Q?mf6td2hZooLQb4Uerv4WuM9N6LwEoE+apv3NJTcBrS+LSkECOYNow1IfhfQ8?=
 =?us-ascii?Q?R9vLBP426VnF4DZ2j5+xQM6IB8uiHZPZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 15:01:29.3403 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8554395-4240-451f-ac21-08dcacbaa9ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4316
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

It's not supported under SR-IOV at the moment.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 3 +++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index d69a0e2f6eaa..df5018b4e708 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7146,6 +7146,9 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
 	unsigned long flags;
 	int i, r;
 
+	if (amdgpu_sriov_vf(adev))
+		return -EINVAL;
+
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 221a7e1725c9..7ac727f6b9b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -3308,6 +3308,9 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 	unsigned long flags;
 	int r, i;
 
+	if (amdgpu_sriov_vf(adev))
+		return -EINVAL;
+
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
-- 
2.45.2

