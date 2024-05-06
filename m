Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EA4FC10F16
	for <amd-gfx@archiver.kernel.org>; Mon,  6 May 2024 09:26:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC52D10E847;
	Mon,  6 May 2024 09:26:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G+nJNbpm";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2053.outbound.protection.outlook.com [40.107.95.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EA1710EAE1
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 May 2024 09:26:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDGOn4zsK0yohE/mKSJdZu3X2KDlo8hipZ1di6jFxxGDBOGzrZ51HY/EpZgSNidaW9Ofbjuv1GFPqbi8y1+bMw0lqjUhkRJv25jTSaFjdnuxQuqcTpipC7zgzcyyoS16nF7VCcJEWrQQbFnUbJXswKpo63w5Lr8h6WXnuzXnFY2ZPl6/RYCuI7LhIEBxWOTXzuJ5/4faDXE6BEKZcK7Ap3iM1DdHFI4lyIbUhMj0JlieJjoZNW4xzXeIro9kfGEOuMgZshV4oJyPbcm2wAoA8xsRUt54TISAuxPdlzo5RjPrWB038AR6PDaEG+Q6gMkdkcn6e8A2PJM4ag7RSzXqFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHFtyq+7Y4MIBF3Pp6745UUeV52JlF/qmqljQNGyfVM=;
 b=U6acjnhmbVNZoRuHYWTeFly1EBFv33subr+wdoGhNerENLGfJNHPh+aDEeYMp8ZSJeYNFFFVjQ/8QWNgvRebSCY7meH58xzRQpx1YErwwgXDAmg7Pmn3Kjql2BtBvbyW7xZA6bkddM8/EYfoYOD5PWpHtzzEuEtFc4l3iY08mGWcIHwQxhYEFAHE3JPo4/+BbFHximrAfSSx0tIwYEN+kUIpEdJsiMMAHiZkWJmxryvFRqb26i/yX86QwUBqhE7pSOdrARJKSbgXJokIb4Gqvvn3A5Fz8x3nHtSdQQDl9Zuo0XYD6R09uL4C43ALu96IxS3yMKZGa6mm+SW6NIuHUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHFtyq+7Y4MIBF3Pp6745UUeV52JlF/qmqljQNGyfVM=;
 b=G+nJNbpmljKWNmvXu4Y6xU0RnxryV0Hcil4kwBFd5SiQFhuUYPW2A72+wnHwh7zCKR7npKIV11K07w1w4j2TLo6+ZHoEfAb7OPKdmMX72qxXcf4saGl8J52IW7RYBHPJopFlm/LkXS8cImGfCBREJuBsEhNR5N4YLLcUFIfECMs=
Received: from DS7PR03CA0073.namprd03.prod.outlook.com (2603:10b6:5:3bb::18)
 by DM4PR12MB6088.namprd12.prod.outlook.com (2603:10b6:8:af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Mon, 6 May
 2024 09:25:59 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:5:3bb:cafe::ff) by DS7PR03CA0073.outlook.office365.com
 (2603:10b6:5:3bb::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.39 via Frontend
 Transport; Mon, 6 May 2024 09:25:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 6 May 2024 09:25:58 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 6 May
 2024 04:25:57 -0500
From: Tim Huang <Tim.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>, Tim Huang
 <Tim.Huang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: fix ucode out-of-bounds read warning
Date: Mon, 6 May 2024 17:25:14 +0800
Message-ID: <20240506092515.2027655-1-Tim.Huang@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|DM4PR12MB6088:EE_
X-MS-Office365-Filtering-Correlation-Id: 42a36b13-e961-4133-21d2-08dc6dae8a24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|1800799015|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+Hu4G6l13gxMixdSyYL4Liu1uTqb7LadYFtdYSV7MOIOw/DS7xceweN5jGQH?=
 =?us-ascii?Q?UkdYM1aADZ5mgvrk0eyVAr66jfjjUadVc6nV0bQE0kvyG0X9I7d3+TMcrP8P?=
 =?us-ascii?Q?o9NYbkBryJWCyeKVBUZ4gQMNVO+3NpU7DxrLGy0kfbW+NZF3/wpjlGoH1g9v?=
 =?us-ascii?Q?31hmO4wV47BgqCF9GP3GEZ2CuF4hVxXF019mz4GAdiUKd8H+fq/qHqf6Oh/n?=
 =?us-ascii?Q?HIISOS5l+fQsGr48tMmJwdMbDC9iaOKma/gUQeScnl7pkqrwzqfobMw9g01L?=
 =?us-ascii?Q?rMjUaCf4NHHUYjfccqEdF/JGzic4XdykMY8Ibe1zkXNuTnH7bHWP9dfvMJxL?=
 =?us-ascii?Q?5IXO4BD2ZqRjNVvFZtabHUNkeL1ULcreqwl5X+uhbJ9bmXuLVyKF927pJFIF?=
 =?us-ascii?Q?4NOMKbmluop27F7uvZjqwl8VWPsApUvHnAM1llairLKpz+ixsZv55KLJrAe8?=
 =?us-ascii?Q?ZSz8P0wSDLvV2ZR0jSUwFgJhQO65fmmv6a57ZZux6lj+/AX6yejE8miMICP/?=
 =?us-ascii?Q?U7qTk9kzACKzW5AqNv/81pjjAaXVF7fmOkmf8JZCS/fnNi3RAGFkfYOlCWS1?=
 =?us-ascii?Q?zZj39qEeffTgBsYx56XmlzWgGcOxvnhFLAmN+AzRLR0YI8cuY6aOp30y7+/C?=
 =?us-ascii?Q?+q61NHg8VL9WoHxSmrUupre6hmWBdTARfU8VzeF+78cL2cso2RU6BknK5FdV?=
 =?us-ascii?Q?Y0ged7Sz+8PwaZ5wSbqzOC6LXh5k5ZSYl3AkUIWoXXsYyfOrSIJqCRY1po+0?=
 =?us-ascii?Q?j6uoCUNuPqqudsMLIE1ZqX4vUnD0a8H2GBpJkeP0Babe7dp3ZM5g1PC/5Y4H?=
 =?us-ascii?Q?YPDrErwN/noFbiI/onwOv3JDBez7YtoIXa1LefshORgVlYqCQY1WkpJUS/xv?=
 =?us-ascii?Q?LHG4e7NcKBnB9NLKX/YcH6Kmy78kV0ib8hufmpVUO1jd4lp9IUOo2BICz0Mk?=
 =?us-ascii?Q?/sQiXGc/cMlr13pGmSZMHp1ozX2XAr+X5GTZnku5bSZmS5jn5CINd31lwbPU?=
 =?us-ascii?Q?Z2RniqQ9rKN93YRWPhXEqZ9DeJmEj4iX89wTf2z8TDxAK1xwTCyTOlo3VyL9?=
 =?us-ascii?Q?7WUxejaNIFrermUGnji858NPVV9mPCdk/pTUfWY4DSyV7XAyZlRpAJzdxh8i?=
 =?us-ascii?Q?iikfTPh2UIbwA35DZKgsMTbNzPs1nvU8qJVNP5lk1YQdCBsqZFAw5OwshJE1?=
 =?us-ascii?Q?+lBbgRz44ThnJmDqO2ZZq0ArjVBXQCVMxUiHWYaHogAmw2dYh2GVLcNfPgUt?=
 =?us-ascii?Q?REMwPQsNUDxPxkkf7f3+NGNOhZ14raeTj2b4SHCiEn6nzyLsZWLVNLA0CymP?=
 =?us-ascii?Q?hlXWQ4VS4GmmxE9uJe+nzUoa9pbdaermIR9Ivb0Y7ko8w3QLPNelpFsdpz2U?=
 =?us-ascii?Q?C2XNxeG99J3p5W1KK7k8TIyL/dbl?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 09:25:58.8347 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42a36b13-e961-4133-21d2-08dc6dae8a24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6088
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

Clear warning that read ucode[] may out-of-bounds.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
index b8280be6225d..c3d89088123d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
@@ -213,6 +213,9 @@ static int amdgpu_cgs_get_firmware_info(struct cgs_device *cgs_device,
 		struct amdgpu_firmware_info *ucode;
 
 		id = fw_type_convert(cgs_device, type);
+		if (id >= AMDGPU_UCODE_ID_MAXIMUM)
+			return -EINVAL;
+
 		ucode = &adev->firmware.ucode[id];
 		if (ucode->fw == NULL)
 			return -EINVAL;
-- 
2.39.2

