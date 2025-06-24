Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4155C7EE31
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Jun 2025 08:45:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86EA610E52F;
	Tue, 24 Jun 2025 08:45:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VCKAdewY";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D3D710E52D
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Jun 2025 08:45:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MdVq1v/c6IX/NnFo6MIQV8WvP9Vif6UiOjN2HANvgJMlMf6va/LrCznOPWn5CzCP15WMJyW0Ppmk4z6xbApkYoEcjmaZZxJUtXQTP26KSSFG91bLvVpx1FuxzPEHeN2jjSmQWhH5b9aRUGty9ggqcy5Ru7mUuOyN0/xsQyKYtta+OZmlPQXTv/piFr3VU+3LvzV1K9TFbGyzSP30wI2nQ9tSlpc6tRkCHGObDnFLl6wA+DJ1AGD6CwzfOHJknSRhUzjnR26taysYJoDm2H6CDqZcP3YqXsATW4xCvGFgT55ILkCKaSxQ5YW/jizYADr+GLIVIsOYzS9qyr/Imm+wpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aTbsS+t1QnIXKfZLAImVQvlc6r5CTHaX/UCDNMmUAck=;
 b=LR0Mdm5MRw5B6VyOx1tylaSH+usfY42eip/CO9FdYjP0D3aBRlPcG97ZdOS/2ljsa/Ky+tqBgss1N5r8rMrar8j6IuB2+YcTE8fGxD51+VEzcg66epuRziEJNjc217rkrusd1gNPSUE1GMz2R+67MOO9+pOjnRbB89G/GFmyqZz/xCIy2X7ANKTanqrAhHX3wAS+6JOOpXOTZLcrO99VrhK+FL8+6OI2GFp+Ozo+dvan3dThFe/rfJLC0b+5iT2nxTh2AizBBuOq3LYLMpYIwmP7l4T3bfzjxSo0u1Hl6e/WclURNuyxif7458l9x4g7z1fpth7vEfsTWyfsLQXULQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTbsS+t1QnIXKfZLAImVQvlc6r5CTHaX/UCDNMmUAck=;
 b=VCKAdewY+lj0GYQFoyiWvxe8rc7qc0ADPy6zA77Mmj2eP3SDZD3z/vcclcr3RacFRIsXpQdQRS0lM6unSP0Sbfid//Aoj5TR59ofnkB2ByLjxYdNy61t9rxJ/VxfTxkQnWyLujg30DlkSktnlMxjOf6U09Gi4DEmXQtOt6aQUeI=
Received: from BYAPR11CA0040.namprd11.prod.outlook.com (2603:10b6:a03:80::17)
 by DS0PR12MB8018.namprd12.prod.outlook.com (2603:10b6:8:149::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Tue, 24 Jun
 2025 08:45:49 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:a03:80:cafe::33) by BYAPR11CA0040.outlook.office365.com
 (2603:10b6:a03:80::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Tue,
 24 Jun 2025 08:45:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 08:45:49 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 03:45:46 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v4 02/11] drm/amdgpu: validate unmap status for destroying
 userq
Date: Tue, 24 Jun 2025 16:45:26 +0800
Message-ID: <20250624084535.1178476-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250624084535.1178476-1-Prike.Liang@amd.com>
References: <20250624084535.1178476-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|DS0PR12MB8018:EE_
X-MS-Office365-Filtering-Correlation-Id: 40d0fc4a-dd3f-42bc-1c6a-08ddb2fb84e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2KcHnKaXJqK1H9biDcnOyhB80ufzsvJb3iUYDJXIBOR9syQT5BkrAqqQ4oVq?=
 =?us-ascii?Q?WNawGnd8POwGNPamSvmSpDpHjj/8TE9Yzt45Fl9oC+WYSulQi+ivzPqPI1RN?=
 =?us-ascii?Q?3PASIUXXwm3H5SPa5cODvuSmGlS36sx8xUVgw37aZcJWVLsh99IHvG2jEvhj?=
 =?us-ascii?Q?IX455VFy9l/MejCp/z4z0Hx0Bus+jIJqrA7t8pHGlphgg5w9k7foxFHGV+wX?=
 =?us-ascii?Q?ThslFd7d/RlkBOfmE0z3jsYJSU+FYw7qzFwTz/nlnfmGRswlRu9Ima0+YH/R?=
 =?us-ascii?Q?KtbDBSwrCu8P8cngY9NKIl6ZhmCJ+4Ulj3DGmj0v/rzIo1q/SQ+fO1PnthHZ?=
 =?us-ascii?Q?DUMo7Ah3YVxIeEnw18ZwPOBjvMGdq0uDz1ddPbcR9lOqOPxt6MyvS8CKY+E3?=
 =?us-ascii?Q?3h0ORBcnwvv67FnrNNhjTfSmkmWUmZ9DLpUaY6OWJPAyzt6YuLjb3bASIH+W?=
 =?us-ascii?Q?sQNFIXAYscFOVXnay0vEY14vfiUmOPOrbVQ5FrSC039sYqMW3pGk9XRQrXEm?=
 =?us-ascii?Q?cqqiBKi9LdLfuCyD8uhDZeWonXgmYbIuEeftaQdn5zUSYJW93N4lgFtMTnLp?=
 =?us-ascii?Q?tcGYY49uBUF47q2pRQnJ83qJszgCp+eiYRPQG9XWLgCf5OMBNmQ9lfbWQmKn?=
 =?us-ascii?Q?5gtBG22t3vDZKaaSFuF2fKWdOOad7uQlej4/WhWa5tUFCYlZc4ped9H7DEW1?=
 =?us-ascii?Q?Ich+s3eLbP6ABRsGULA1rEVfVpDrL6K3z7sVzBYB1OLbH/evY+DNt7XWl2oj?=
 =?us-ascii?Q?biVwsShmz0Kwc2MslyQlqutkCWicj5tgv/qvSmzEEUyw5bYULbp4UI5UlOcn?=
 =?us-ascii?Q?iEPRwKUwIIgev13YfjGn6OLOWJufsaqph47mnpvbzskdDZ647mLvK8dzTkE5?=
 =?us-ascii?Q?ox/RF0KuTzElNiqxQ83MoA2puspOStkwnR/FkoUwDfypO9gRtRcUcxIcW1sI?=
 =?us-ascii?Q?XLX4vsLk/FO1dRg+WVQjLjlm6Tn/FXmwkia/ELFSXTw1bBkc84/+kH/6idCm?=
 =?us-ascii?Q?AZaBa2lQHTt1pr1ZScXvg6bfQDliXOyX7PgnSxN+mxfbjoRy4iS3Nriwe71V?=
 =?us-ascii?Q?fn9CDMPtetwE5zxUyV3UtY4CiG+8hdsUb/aQtAWLCNO61wG+HvVDEo8y/vor?=
 =?us-ascii?Q?J2VzXZyPv6xa/0XiMx3qX6YSDpmQmtjYUf7p/eWecE9yBhWMX3QIb0kRw5zG?=
 =?us-ascii?Q?TnMBpPjM1VxHruI9yHb767KqRIalIR/LlYlBuVaR8tE39rQRuO1wAv4aSSh8?=
 =?us-ascii?Q?96dfjkoDyx9vKRA7eEKpvFsqpEL/7FDEF1AAyyCrhVQLvKrSIbV+rWwOa8K7?=
 =?us-ascii?Q?xThB0eWnRndHrWFHRzntHJIECtXRQaWhCND8aQ9Oy0PTBe0xfngxokYl50/O?=
 =?us-ascii?Q?ZiWCJzXgJDMWgFb4sBe/QX1z+VcBIglz2Xb3sqlPq9i2j2+qggzcdU8xcI95?=
 =?us-ascii?Q?f9nkRM7rg2G9WPOuOibP5+jxcuB1cNc/ZAO+xqFP/B1Asuq1XXZDciOAvJ0g?=
 =?us-ascii?Q?hTUnr16J9TrA3K5Upo7WjFfgtZ3wB+1LVgbN?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 08:45:49.1882 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40d0fc4a-dd3f-42bc-1c6a-08ddb2fb84e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8018
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

Before destroying the userq buffer object, it requires validating
the userq unmap status and ensuring the userq is unmapped from
hardware.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 7f9dfeae4322..c7c9f9e597f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -319,6 +319,11 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
 	}
 	amdgpu_bo_unref(&queue->db_obj.obj);
 	r = amdgpu_userq_unmap_helper(uq_mgr, queue);
+	/*TODO: It requires a reset for unmap error*/
+	if (r != AMDGPU_USERQ_STATE_UNMAPPED) {
+		drm_warn(adev_to_drm(uq_mgr->adev), "trying to destroy a HW mapping userq\n");
+		r = -ETIMEDOUT;
+	}
 	amdgpu_userq_cleanup(uq_mgr, queue, queue_id);
 	mutex_unlock(&uq_mgr->userq_mutex);
 
-- 
2.34.1

