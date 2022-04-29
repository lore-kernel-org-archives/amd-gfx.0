Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78601C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:47:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B08C10F59A;
	Fri, 29 Apr 2022 17:47:46 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 675E710F73E
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:47:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JVjMBVX8HScajqAinMzWTrQ0QQFgx+2e+sUfBA4n4bfJQYwK//GwA5RebdxSofLOmzk2hPgjg5FuUPtwv42Wt8FTc7jAtwanfh3RbZqX9Pivb0z3X/+Q5zvL7z9L+oxEgTsDQdqts+tB1dsxr9Oi3YfxSHobjEjkS+FxbdDNFMzt897+TQNcCH42g+HMCUnRMg9hUkWtdXTFwE2bxPw1G5T1kXu5C3Gh+UXmTxd1fKgAdqfVuC/LytkDX7nD6EGfRbPhMfYwa/CLiHZ97Rl916+veSoJsjSU1ULXn2V1q7OUSDlXXiyrXTau8FdTxIBesPtiXwuFDKZ47iZdpTzqxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CrzeArG/3D6DA3fPzMpqu0PuzNnJ18XAo8BkoJslFGI=;
 b=m9YlXOccCOLJKl5eCS9Xhk6ryFbjV4hXF33Fht5fHl1xWGaE73inmpzX80wAHeVNchySAuiYkztnZSivWz4XeCROR3mj/NWiti/sEPttIda0bOxE7a54DZL2YJhFzmOxQg09nP7OnzKANEF+jczzzrbc+yHoIjtFPMJntCVjjViPNnuzBZBrhn938x/3DkX5MVGoz1bXC2c1Do7DfuaSsFZ7fanoX1lf4ZGnt+eqiPbXursmihOJSFT0I4xT1SVR757XmkKYTICt2qU4pZksKVHGsmFnf5KigRxfq37q/I7mEfqvOSvu5a0aNpNqE0uVUMbfRcK+immhGYIkBuTRXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrzeArG/3D6DA3fPzMpqu0PuzNnJ18XAo8BkoJslFGI=;
 b=tAV86i9ZQYaMnBL0yV593mYxPXDacPC0PLYZkZXJhAFLInOvDRd39adY6G29VHYpJ84ku2T54h2kByM1n0oMaWZio4sAUIkwkKlHpxv+LwrxbKs8IqsK6/BUfHDdgUIGcdNirzcgMEO21tpAaKtoZFwKjNeJagUktYZoiGcNhvM=
Received: from DM6PR17CA0009.namprd17.prod.outlook.com (2603:10b6:5:1b3::22)
 by BYAPR12MB2726.namprd12.prod.outlook.com (2603:10b6:a03:66::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.19; Fri, 29 Apr
 2022 17:47:18 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::c1) by DM6PR17CA0009.outlook.office365.com
 (2603:10b6:5:1b3::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Fri, 29 Apr 2022 17:47:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:47:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:47:14 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 63/73] drm/amdgpu: skip kiq ib tests if mes enabled
Date: Fri, 29 Apr 2022 13:46:14 -0400
Message-ID: <20220429174624.459475-64-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429174624.459475-1-alexander.deucher@amd.com>
References: <20220429174624.459475-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3d38c2a-8b53-4391-e3c7-08da2a084e13
X-MS-TrafficTypeDiagnostic: BYAPR12MB2726:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB27264CEFB855FC609E4308A5F7FC9@BYAPR12MB2726.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rAhkWRL9bYvvKidxALTa2Ga4DSdBOo6xFSvQ2aAUOypYgxiwijExLaL5eplKUvYKkJgiMZ//3EOyMwEAYQOJSD9ZbMBHoqevgz1w+ecczfMCwN+C9xFB3qnC8EOnnyrMpZChQRHCgLX8jouafoRmeYlFpZZofIMjOOPGfgE7cX0eIJAXLw2o7djh36Eg48PBrGK283kpro9YXuQcH5LPXPmSOahe9NVg8B2eBz6A16piHIfISuMTux7GSbwPbPB9XAcRfYu+sh5p5hVZz4+pWbE/inqmFzbHMNaMyrmUc9hAMj0MlTkWJF2ydHgmmnFKsDis2HwEmEjZyIAkQQP0fgbG3FsGDlZci6dtECpP47HHa8vNDwiZyAkQANVjef+NiIalcT4DYhq4Fmet9JzRWR60FBFTQRcZmIykHT3hlGgkpk5NzdxC4AwPR7W/9sds8TR49mp03S5HDyaPNzCJOz5qelf+YSZuD0Bs0sg2ctJTXBL10S4X3PXAkjGQFh6i50SNRf27zmeUhoR5H9by1VzkMyoI5IjDQaDzOxoXlFbr8aOTl138PF1/4dx+0JSBI7nq49vGSqCQ9M5ZgeO9oawDhbcPuzB7PDKUSiG71jEAsv1RtBIR7IozYm8VtlV1vXDG4asKwNYEJp95oZdu4iO4QvEYaPvSL8uRHdLiyHYx5B4yY5yryrBXs64C1SBviYSYx6ZMfs1eBazPKfga1w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(336012)(426003)(8936002)(36756003)(47076005)(4326008)(26005)(5660300002)(508600001)(36860700001)(40460700003)(82310400005)(7696005)(8676002)(54906003)(356005)(70586007)(86362001)(16526019)(6916009)(2616005)(186003)(316002)(1076003)(81166007)(2906002)(4744005)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:47:18.3284 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3d38c2a-8b53-4391-e3c7-08da2a084e13
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2726
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

For kiq conflicts with mes, skip kiq ib tests.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index d8354453cc29..258cffe3c06a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -390,6 +390,10 @@ int amdgpu_ib_ring_tests(struct amdgpu_device *adev)
 		if (!ring->sched.ready || !ring->funcs->test_ib)
 			continue;
 
+		if (adev->enable_mes &&
+		    ring->funcs->type == AMDGPU_RING_TYPE_KIQ)
+			continue;
+
 		/* MM engine need more time */
 		if (ring->funcs->type == AMDGPU_RING_TYPE_UVD ||
 			ring->funcs->type == AMDGPU_RING_TYPE_VCE ||
-- 
2.35.1

