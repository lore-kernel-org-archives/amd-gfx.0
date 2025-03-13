Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C2CBC28B2E
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Mar 2025 14:42:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9C7C10E8C5;
	Thu, 13 Mar 2025 14:42:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nvPrEFQu";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B128710E8C5
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Mar 2025 14:42:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kkcoH9ELiC13EJO25GcYUZAOmraf36Pe/DM2fst7GzH/5ZEamc9TGBAO+n0Z/M72DXDMOAYDImys0/QLAbnopSXqx0Nf6GNKnqMmBchmq0axoPFtiBbmHxfAFIcdKw4pWB5dgguHS7tLyboeDZL4CwCwVfyYZ6AdQVN7Kni69q2VtXD0r/SBO5Yu2NY/Q5v4D6wsWewj6zBsU4UV++Scp+9W3ItJVfszAEsYlVtEUE6JGyFcfz4YiJNvoBltKRxYURFgMHzvqccINqws4rFivnfuOuHHxcRoAmWiCDfd5w7QR3a1yWO9qun4E22bv3MJ/K98PleZLAnzjzvBFjD4hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvr37PfbO4ml4tLBDtFb3mZZtAg2FY2VfuI3iZ9K+Ns=;
 b=y2VigFma0WAox0TkmsO7G3V/kpE6t6PGJt4r8NSErBvVr3RdfWwOrVgMYc/q0QQgrCY3++haFottAmJ7pX8o3bOAnwMjHdGQ3JpCCr/nQNtcqROVi6eh8OOHr6pXNx/SKaZwIvj64hTSdS1fQ8YgRoVFxnnV6T9M2IWjaJ++U+dSgz1woh/2su/ET0KSfUQOsqJSwhg8AvIaYobb7A4nSoaYngcTIr3ljV5YzCVpJtS1cGBnnZZnkdM+wvANEq0IK8PbNDVCNy+PfmnKj/odHhxObvP22Gt4EEkQaxqBK5XTsfn1G7BQA1J4bkZiIMZe8/On3xiQsLjprhd+uYo9kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvr37PfbO4ml4tLBDtFb3mZZtAg2FY2VfuI3iZ9K+Ns=;
 b=nvPrEFQuKxpKZeGcyKsddSsg0wKRxY+ghyjJ9dKxEnk+pdrI7AbyIB/S3RelkmxpvI5ruJmEgttWb7pdeuzqTyXrU6UOYR1x3pcbTYbBU1RWzcMxmN9HicYZDtr6W5gTPZ3OxX8yTVZqLUQokpe6Z+7oT7uTqKevuzgpnYZ3d6k=
Received: from BL1PR13CA0350.namprd13.prod.outlook.com (2603:10b6:208:2c6::25)
 by CH3PR12MB7596.namprd12.prod.outlook.com (2603:10b6:610:14b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Thu, 13 Mar
 2025 14:41:59 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:208:2c6:cafe::42) by BL1PR13CA0350.outlook.office365.com
 (2603:10b6:208:2c6::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.26 via Frontend Transport; Thu,
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
 2025 09:41:57 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH 09/11] drm/amdgpu/sdma: add flag for tracking disable_kq
Date: Thu, 13 Mar 2025 10:41:34 -0400
Message-ID: <20250313144136.1117072-10-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|CH3PR12MB7596:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c2f5919-99d1-4ba3-068a-08dd623d35d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?i6jfSGJqaKjZokgayT9l1q0FNgYKn7BOmYOaKWxaINSqLwjgAIh0Ca0pv2VT?=
 =?us-ascii?Q?iz94aaTkvzAFtfunnsaqk70ipj8rzWDVbp/74hknVs+l6nioIrx9JfdimuWg?=
 =?us-ascii?Q?RkCSgMeYviWsiVVWtAbPX4e7Bn8ywIfI6iJvWhH1URsv9ppP4shahopX+BxQ?=
 =?us-ascii?Q?vUivW/Q4EPSFwDPYQSMFtyJhUOty+TX0awsmEyR6yl++8089XL1JykVgeOKj?=
 =?us-ascii?Q?G2biRchw52QGaGMpLOD4XqEoLuCIPEqBCJ0RIKAW6ihA9I0j9gkV9z6L0QsI?=
 =?us-ascii?Q?vTX866nsfCt1Qp29o8jMZkS/Tcq+wgNA0rbQjclEeMiG7Zn6o6z3d5U1M5Zv?=
 =?us-ascii?Q?xo8+AB/Yy+8h6KS/5th05E1sK/PbWrVMuorgEJv9l/8caMCmmDbyN2eK/zYh?=
 =?us-ascii?Q?j1w+hhi3LXTkQRLJpzd4jg0kvdEBNY2DuGdKvmvZejrPx0VUPHPwVRNp12MZ?=
 =?us-ascii?Q?qdVuZOVvXEUwjml0azoG21Dwt483ZkB8GriIyB6z4Xj2kcl92hWu5S6ZvGGh?=
 =?us-ascii?Q?sbwyljIf6ZI2h199kR92qBDjUcjOkyXC0V1FaVk64Lq4o+2Ls8LZZK9aJwrc?=
 =?us-ascii?Q?2hJ1qDU9ohEKfCjNdM++fBHte6duW7KmnorSjBCLf2cufWxLjjVeZnuoXqN5?=
 =?us-ascii?Q?EaOSqkr95eTkbCc7VTbA7+pltLijxJl9AcbpJ76mVU3KQgQ2rUn9PrBBoeiO?=
 =?us-ascii?Q?hFibB3ziSa5KFvzSwSVaT9WoaDznkoXh8iYaVVsN/k6w0V0JaVmTNJpr71/M?=
 =?us-ascii?Q?dg0hfE5pXCgXv1Q0flAyZ6RQ2Xqk3AUqnAmWBQ27e+VFsQ6cLUD5kRzdjr2T?=
 =?us-ascii?Q?Cfh+/kFiG+XhvVAXk+xxVmyQkTRx1mrAsXprYQB99eQtt2uYF+iPptygJXI7?=
 =?us-ascii?Q?zsg/8QYlaYxKHLqQZqsuWJRZvBI1kYpiXBTDRm+6/+k8Q3aGJI7hISUBy8XL?=
 =?us-ascii?Q?/GjJs7wlB0fzJtnGDnQP4Tnu4UnHBfdgDEpysKVs8t8nSptRDDQ4fleEoDYA?=
 =?us-ascii?Q?e5xJT5Aucq7oHqZTyOYc5wgZ8qtizLS6eCWB+OO5OYK9x7ZVhiVKea4HYgt4?=
 =?us-ascii?Q?4m7ZKp+CwD/ptrr0u/yFZSCJ8Tj+4VUIZAjMSNmZoJg+h/140MKQtmN3F38j?=
 =?us-ascii?Q?4Pu65x4qpfYZXnAtVKLV5FF/9V866+a/9LNaEsgcPgEYB4Mfcil3WCniltz1?=
 =?us-ascii?Q?+MzzqwORgzXupAHyqxM3k9+vO0uU6Y3U6kpz55Byq9m2zRCoZKHMMh2vy5Xl?=
 =?us-ascii?Q?74x9R0qx9ntdvq9RDpkV3NzDLeUqB/lN94chg2VlMHXPOK+qZxcGhyzUgGZ0?=
 =?us-ascii?Q?Kis2m96Ox1Tul+9fjQyASenOlwhWzP1QgkLXN+UK3cXjtNbmuKp3wM4s70/O?=
 =?us-ascii?Q?9fidIoS+HN92BKONytcCJ+7WV7hqAW8lRBe8+uQuK54/cQp+GDlp1yB0wl4z?=
 =?us-ascii?Q?ZwKhKcSJyrawFAmaFp7UyDIdfxm+EfIcgpSbQ+3V3JRDe+GLRLPPIQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 14:41:59.1362 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c2f5919-99d1-4ba3-068a-08dd623d35d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7596
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

For SDMA, we still need kernel queues for paging so
they need to be initialized, but we no not want to
accept submissions from userspace when disable_kq
is set.

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 9651693200655..edc856e10337a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -129,6 +129,7 @@ struct amdgpu_sdma {
 	/* track guilty state of GFX and PAGE queues */
 	bool gfx_guilty;
 	bool page_guilty;
+	bool			no_user_submission;
 };
 
 /*
-- 
2.48.1

