Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 125D2C54ED1
	for <amd-gfx@archiver.kernel.org>; Thu, 22 May 2025 21:56:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BA1310E703;
	Thu, 22 May 2025 21:56:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Bozf9WAw";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8824410E2B3
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 May 2025 21:56:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PgL61GlgKJgSUcpFbShvEmKOsZc18vdUf51pJ4DJyUaZ7fTsYWq0+spe9qAHvq/TzVzQb7+1G97izCbBxFPkPAqZvBbxnLHxDu5HYTzwSsMF9B3wGkUd5Ve1BDOtPY/1iBHxUwB/QLsF3V+aNgSr2CQHZdK1gsLU8kuLJKmuPXdbiwrWdH1QdK6YOhrJTZHhaDJ5t8jadntGMSHOrUS7OTo0HJZ51Eo173R1/VdX7KHK0kz1Ep9ZZlE5qt6qBY5dzomlc52fiEA3rkOtWymEkMTZGwNK299JcdvLb0IngLk19bYNxwL0Ym1umInAEBvWfu8wuUYG+Du/HJlZ5V27MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NjqpcKKQ5N2NyQy72IK8Q05svBi80QiZDgdixwJVWwg=;
 b=cAKaVrftb29d2DA4wVrlqkK7OSBD7khk+ZKYbO2AlXGzzZGv4uTqf6FcM9T7pkqHVzEgY1j2nnoocFbSEflQz56rp/OMhmT7SXOzslR74IkSE1n2E9STQfBG/Kda+3W2gt2FsqiDiAZieAsCvp9nhLBIkrYp07hmtKtAptQcbK+sN6Dfy22fPkj7aZaqR2Ig0Xh/0nX0v4sKIFgsYaLP7dPrOxhJ862yKD4e6KfABLdwV9O3Vr22AgWw9+deZKTVbjqGj6jzealnO5Va2MaKJ8/uuc9X85Pi+uP2CNRDq534hNPRCXd1MApl96tL0P2y/0wNIR2fkgiWZQ8E5S+Fiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjqpcKKQ5N2NyQy72IK8Q05svBi80QiZDgdixwJVWwg=;
 b=Bozf9WAw+pazg5+jj51DgQmjsQtGw9tDRQbfpywQtcdYgLM4yhfXnMjqzY1egW+hlYOA/WwNXd7hM+8MV2L/QXESBmhtcyaoeja4v7nkzx1C4puWBwaCRJhgSd8+v7PW3KSkBlF6QvjpcCE8wODJuLDpF25ypyCvzuqhDgvxv8c=
Received: from MN0PR02CA0020.namprd02.prod.outlook.com (2603:10b6:208:530::31)
 by PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 22 May
 2025 21:56:15 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:208:530:cafe::4a) by MN0PR02CA0020.outlook.office365.com
 (2603:10b6:208:530::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Thu,
 22 May 2025 21:56:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 22 May 2025 21:56:15 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 May
 2025 16:56:14 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 03/10] drm/amdgpu: add AMDGPU_QUEUE_RESET_TIMEOUT
Date: Thu, 22 May 2025 17:55:52 -0400
Message-ID: <20250522215559.14677-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250522215559.14677-1-alexander.deucher@amd.com>
References: <20250522215559.14677-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|PH7PR12MB6000:EE_
X-MS-Office365-Filtering-Correlation-Id: e76a1eb4-9b8e-4c42-153a-08dd997b799c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?30lDLvOpBe4kFWvy18lBWwi5lWzc/tVAim+nT0WiMUjn6ubeWIHjlOibDlMS?=
 =?us-ascii?Q?mdzJKIP0EMCM56VSAbpiRH7JmBJtR/D1xxx+OOTxIcSFA7qjrrd72hiHdnQt?=
 =?us-ascii?Q?wxEQU5n9uqh0YhoSkToxSZ6WQ/iswGhnA7+ghjg8hfXgXYwjD79pIbkR152j?=
 =?us-ascii?Q?aK5OmSV5Uq9M2n0nF9q5nBx7K5k2pZMDfhduFF2+PEn2EuD9dq/Y4F/lozdw?=
 =?us-ascii?Q?6XsmmF5QutKrTcaM68liAdoEYFpi112SOnEPx+B6U+rjqRzeo0CUc54kaHdE?=
 =?us-ascii?Q?dQbd3R9CC/UOTo6JyB9y6Gju+v2w8C6Yb9UE5psK1Rzis/8RBIk3eD7M9MOb?=
 =?us-ascii?Q?BbAYWsNp4t5Q3wQ9cww7vv9jFYGTlRoezmIOa/z/ybt2V/OhtWdV7NBLZnTI?=
 =?us-ascii?Q?Sc5gEqlWJaeXwnhGs/3Vc3Kg0cATDp9nEcpsPukWEVmuEQi3ancDhK56Kpuh?=
 =?us-ascii?Q?eh0of94Ba2TGh7YHBvxmTU5/Le0Kvc0osSoOL0+HvllHWHp4DNG28VePJdbp?=
 =?us-ascii?Q?BKLWx/ryGCVhhVCa7lqxpAIEsPtYLkdQpX2EmnGAH+/+gnmX1VvMxczNv4QE?=
 =?us-ascii?Q?M+2ArCb6uv9uatEHuS3YEeTIpx0tXZ/djv3sN3TLFkwWMEhZDQk07fk0ZipM?=
 =?us-ascii?Q?jxhOPX5TNdNVXnXlecRUPqygPJxox7Dya/dNCEPVn+IeFC/3G3J7oFCeOl1f?=
 =?us-ascii?Q?IyaOepZzKdP1yU9zyN8Tuj8g1Q3Ml0IFsjEh+SHldm+QQkDYmMr8N5qMQpIi?=
 =?us-ascii?Q?Hy33G5B4i3x6tYeqB8xgDA4qp6B2hcmQI4Y0oLZmfMZtQdc4O4K+aPaDPRhz?=
 =?us-ascii?Q?JpbF0x3Vfd3bGC7m9FTNZG4Bhs/Gg2xKLdvatH5pQCI74GE2wGI/ZtEoleRS?=
 =?us-ascii?Q?Ysmkrrbg4M+glAfn/8R2Vv0fCzw8dsOY9FwZf/yOYJ22dwVEFu+N3JQuYmE+?=
 =?us-ascii?Q?XRddouKpk9+16kUlfsfQeszV5S9HuNdntbcKliockKzQOxLuDBpxHB/dgMY2?=
 =?us-ascii?Q?3AnsTg9Yn/kVtXH5FX5rsIqgD2Ockf8u3UKVyDW9XlPFoM4ycPI4wj1PZBS8?=
 =?us-ascii?Q?VepldiJjWB8geH5RMTSqLztSwTURbRiR6NIEQIN9cgCuyeq8qRk0DcwRLaok?=
 =?us-ascii?Q?HRfGtPONYjIms2OK51rI2orRF6Km8d72xpleOp9PnEXqH5z9nYIezEuKiHe2?=
 =?us-ascii?Q?2WbvVqwHtVFOplFcTvzBW3Er+m6682+P9gbjlj1e2Xswv7PyUVZy458U1K1b?=
 =?us-ascii?Q?uBnNBR5J+x0zwtVybTEoc79sfPfssOmCgi2b46Sr7EB7Y0DiT81QCEzKk8CI?=
 =?us-ascii?Q?OyaOCeNHsjSlSG4RupUNEshUg9RP2qTZ4xWZjNHjDhuIRHaG2tLu9DICbiQC?=
 =?us-ascii?Q?SQiePBDqTvnK9pMfDUUgGhfFYukpnmnQ51X8/oCjdGDaVQh9Cpf7byGfSCDU?=
 =?us-ascii?Q?4Gm6eOqZ7icKRR6hZDh/QZg2lN6eycN4gECtRXR/kpHLJIpMUUcT11Kby2WW?=
 =?us-ascii?Q?7xOfT8QD0/jAk8WsDKkTZK8rCFPKKZbSFpo2?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 21:56:15.6373 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e76a1eb4-9b8e-4c42-153a-08dd997b799c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6000
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

Add a new define for queue reset timeout.  This will
be used for the IB tests used when validatating
ring resets.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 836ea081088af..af79a03abc110 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -278,6 +278,7 @@ extern int amdgpu_user_queue;
 #define AMDGPU_WAIT_IDLE_TIMEOUT_IN_MS	        3000
 #define AMDGPU_MAX_USEC_TIMEOUT			100000	/* 100 ms */
 #define AMDGPU_FENCE_JIFFIES_TIMEOUT		(HZ / 2)
+#define AMDGPU_QUEUE_RESET_TIMEOUT		(HZ / 10)
 #define AMDGPU_DEBUGFS_MAX_COMPONENTS		32
 #define AMDGPUFB_CONN_LIMIT			4
 #define AMDGPU_BIOS_NUM_SCRATCH			16
-- 
2.49.0

