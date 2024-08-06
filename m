Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5DA4C52D6F
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Aug 2024 19:38:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97B2610E3E1;
	Tue,  6 Aug 2024 19:38:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ov+cRKjs";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46F7310E3E1
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Aug 2024 19:38:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cIlTI3nkwf5GQBMcA/a49Gn4HF00+2A1YrzfW91/wUH7zDh569TJC+XZ2Xf2YsHcH15AmK5ZfVPR/O9yLMcxAHMgalqLIdW0Cg7GvllDhBYyZJBr5Vj4hcnC052cPIYHHMx8/vPesK43eRWvIND1L0QZJOAWzHs01UyiOi6ImT+HPxioMWTt2aNMkZA3eptDxFgH50bSFIhU+YpnXEv0oiuOc+XvAPFxVA0JF+/vsMrqXY59z68s0SkTbkYPrVDtIYJV4OREplvPxmfcKQcIWp5rTRALpbAL8HLhbK4+WhgPpvmZvE+qGvJQfULp0C0U3DdiJf1ZAAthE7n/ZcbY1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfc5YNtb4LSGIg1FqXZ51V+3fvVMadMxCw+cQZNwW2M=;
 b=BUlFblIBWHynGfGJZKw6UkpN3MXHSS/p8Rt+U9cLiwXXjHh/dhMK6ibGw7vhG2E+wDq/bAV9ecK29PCo0zPnTKnzok35GDPI06B1afXizl4XERxNIbSGgyZI20Zsr9AA8w+49b3c6BeEE6KiCKmapa4xgwnCVIUU15mPf+kqIXuL75epOzkrhUe/0Wk5wMZu/BMjFYCkUFmsY40g+JODsWddlaWVzbiLlirfnQXvKYiqpY1kWPGYZqlm01l+9pqqMeteMGm+DZu+ZfqnOgnW7fEX4U0ryMQ+SnJMmSiwTjodDdjSPYy3J1y/Ft51QwcAji1it+klfNiPVEjvi7QdyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfc5YNtb4LSGIg1FqXZ51V+3fvVMadMxCw+cQZNwW2M=;
 b=Ov+cRKjsHUaAYEkFew7uxkDzRYzEE9kQzeG4CuB4NIypnJqtYUAmocGbaVxt7DzP47w8sIGq6vHgmpoOGNK6vJoPdfG++a4Dep3MBEyV3iX7+Te9SdvCn+o2it84of3k9/NBucK+XwFPDiqiRvQuVWn/mXd6Sb1s9ANKIbIWUCo=
Received: from BN9PR03CA0578.namprd03.prod.outlook.com (2603:10b6:408:10d::13)
 by SA1PR12MB8094.namprd12.prod.outlook.com (2603:10b6:806:336::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Tue, 6 Aug
 2024 19:38:19 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:408:10d:cafe::6a) by BN9PR03CA0578.outlook.office365.com
 (2603:10b6:408:10d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.28 via Frontend
 Transport; Tue, 6 Aug 2024 19:38:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Tue, 6 Aug 2024 19:38:19 +0000
Received: from yinjiyao-test0.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 Aug
 2024 14:38:17 -0500
From: yinjiyao <yinjie.yao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>
CC: <alexander.deucher@amd.com>, <leo.liu@amd.com>, <ruijing.dong@amd.com>,
 <yinjie.yao@amd.com>
Subject: [PATCH] drm/amdgpu: Update kmd_fw_shared for VCN5
Date: Tue, 6 Aug 2024 15:38:05 -0400
Message-ID: <20240806193805.200607-1-yinjie.yao@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|SA1PR12MB8094:EE_
X-MS-Office365-Filtering-Correlation-Id: c6fbe93a-eb16-4a48-7bd4-08dcb64f5307
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9MlC/y/xZZuTbo6+8FkN///lCewZkWM53Ktrdgw+Qj4jKWgTZyP2rnAIjQTm?=
 =?us-ascii?Q?2A/N7zU/rJD5gmJof7E87D4XFZFPHI6hl/TZPVl/ss90L71ZWr45GsRRRndU?=
 =?us-ascii?Q?0/CpgNk5eiuiloeu6b5yRCQod/jSU6ODQsHXbO/BFIJKRmq/J+zMGpbDEsio?=
 =?us-ascii?Q?e8ynwd9P2z2RIayGz/0mOqOIBmHImpYo45zggAhj2B+NhLpXciod8u1REoTl?=
 =?us-ascii?Q?wECKUsas7eXLUxmeDfcsJqRE58j9nmOb8yECvlBoDqzxcznX1M3VvkTJ3EaG?=
 =?us-ascii?Q?AbSy4inUyyo714RrCU7JwWFT00Flalz5KC9phF5UKF7qKfHXuIo9x9PbianE?=
 =?us-ascii?Q?bQe4R+Dip7UfExlT4g4zmRscKDCjkCd1WP/1BbmLIydwfLcWnLVyM3Zq3JKQ?=
 =?us-ascii?Q?lzT72ceNyTCoM75HWSbuW9MJjnar6c6Cqd8UopEQ/+wcbqrDXzCyGgQbhAPU?=
 =?us-ascii?Q?LUymgmVUK+R7K+ACESlxDqDMswsPDUfHTQ8QvBs/vOxCMvHwtpmSimrJcCvZ?=
 =?us-ascii?Q?i7klbMdWjWBVpN/1mf6ELV8TOCxGJwBxGIFhCq/pM/TpZHoyoWcfgRIkABkv?=
 =?us-ascii?Q?+AbZcaTVeURon9/F7v2yJtiC5kukQFsqdRth3IY3RcLhhJXvip+jCrVfens7?=
 =?us-ascii?Q?IcwvFkjKT53TT2hzdTt27mkgromA4jxGFOVaLJHjov191Yy/vb9Q4sQM11jH?=
 =?us-ascii?Q?ifeeTROf6QgBeS+7EJVggthQfmUUNkyiwzfrn7nwrwG7NEvqYYROMG8EmcxI?=
 =?us-ascii?Q?QGNH6Ogs+HKng/Q/aXhyBW9sL6r0voI5NMASz9nYkzA/X6neZ3II5hBWlq48?=
 =?us-ascii?Q?u/fUOkx/Nd6jfqRtLHDjpcjTIoO5RqtubQim4kFwtA6oXzO04/C9olbnz9dR?=
 =?us-ascii?Q?fSZPimjtGUx5YukRT2v3nnq2h4qZ0tglF/QdkV9ynf34Iy89urXkrJkO3wS6?=
 =?us-ascii?Q?cAuh6JK2Pqqxzifhn7DIEgBUGSc+ebnIAo0Fsj7z0SGG+T9/gOs95lrvzxZk?=
 =?us-ascii?Q?Ba39uxXlyCk3LCzWG0CQlJ8vFQPHl0FT+xM9+K9dUyAZ4OX3iWvizB8QdKE/?=
 =?us-ascii?Q?bx8ZHgEYcOgHYXlEbb0cynnDRFxm9ogTzk4M8ghyzNofxorq8bRjdHgQCZ9L?=
 =?us-ascii?Q?I642PhO6bAaHBRdsmlAWhaBjS075QKqBe7Ok7Cx4n+BZUCrS/RYNgojsaPir?=
 =?us-ascii?Q?JL9E30XjwuEkhMojB/iALn1IxpgJo5msEsn8gXIO9jOZ+RcKft9VutXRQE9H?=
 =?us-ascii?Q?g8QvEUsUtEie7U/m0Dkg0er7cyU4k8Ttf5noRdL10nZRoyW4KegwsPq6QGpJ?=
 =?us-ascii?Q?CaxnsgWYA+Z3PEa+/a6YRRIzkssni0vdvH4j1eJ/S8zXMo78wNKCntruvsqE?=
 =?us-ascii?Q?J6WDp24ew4n4SHtRMJfdqlnF/9nfOgzD/PVusZMBp4JmD+SWE1l4/evDjDuB?=
 =?us-ascii?Q?fG4F9Q5LpjH34xR5obyZjfHI+2Xj/JhOTo2DPeXfKtpWj1G8W2R45g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 19:38:19.0657 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6fbe93a-eb16-4a48-7bd4-08dcb64f5307
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8094
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

kmd_fw_shared changed in VCN5

Signed-off-by: Yinjie Yao <yinjie.yao@amd.com>
Reviewed-by: Ruijing Dong <ruijing.dong@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index f127eccf59d7..2a1f3dbb14d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -464,8 +464,11 @@ struct amdgpu_vcn5_fw_shared {
 	struct amdgpu_fw_shared_unified_queue_struct sq;
 	uint8_t pad1[8];
 	struct amdgpu_fw_shared_fw_logging fw_log;
+	uint8_t pad2[20];
 	struct amdgpu_fw_shared_rb_setup rb_setup;
-	uint8_t pad2[4];
+	struct amdgpu_fw_shared_smu_interface_info smu_dpm_interface;
+	struct amdgpu_fw_shared_drm_key_wa drm_key_wa;
+	uint8_t pad3[9];
 };
 
 #define VCN_BLOCK_ENCODE_DISABLE_MASK 0x80
-- 
2.34.1

