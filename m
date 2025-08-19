Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCA46CA0EE9
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Aug 2025 05:26:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77C7E10E204;
	Tue, 19 Aug 2025 05:26:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0dU+PXZa";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2076.outbound.protection.outlook.com [40.107.100.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B21110E11A
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Aug 2025 05:26:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wANJKujsY7b7dsYIYxco5k31gKuZE8+NVVTIh7xf3LV3CXcgu3uNN9wAnv1fZWcO73ivS6a6swMQKj4GvQVii78hrhbN34NQG8RmJPKWwZR2Z076/agHjxlLjEWPgM2rzkRfiguT+E5MnlW8UEPcNh5Di0Annrg9BQMggr3pwCcIh2cK8S1mWwQDxqTWv+sTDKmId1WC175Axd/U1lu1MOnj7W5ejhxuDhY8gBRO3WCpnH26FLxkAsblQZEUZIh7DSbfzYv1bdDY8v30dCZogvBw45MaSwM669gldDohtabwFhp/W/ITnCgr5vstOjRf8U5YBQVOhet/Mfa+6+eN0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3HEKNPeXbUpFYA5mn/eE9HLIU7Y5kVjOqwgv3QDFDGQ=;
 b=IAYXYgOfr6fyZNuJHCJwfM80NrI+qeLCHa7+pI5wbz678SeaBna8+dmRTJs7hJEEDQJjXneW5L6R4KRIpqdnQakdlSeRkaz0WCDcqf74VrnJ8O6OcwAvQd8Yu6HsE8MZsEhHSYWqf7o2Ba7orYE3weEgXjPaJot1L9YQuJ9skSWKyEqD4BOa9NOS0J2Ehn9/yp7fV/5sfjhaJfR4/QvPX6JpH5jQfPYQYxXBkPfaze/KRyA2l+rNC3rLXwk3n7XEvc1aY43RVxCBO/y4sXmKgRNBrzIVCG1wcBfmyv9A4XjqxexDL95Tq3WIVaxlOXotszSFD0EDm6BHGoUDJZU8nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3HEKNPeXbUpFYA5mn/eE9HLIU7Y5kVjOqwgv3QDFDGQ=;
 b=0dU+PXZa59WHMTXHw7wLgE9Zg03rH1TYzRd2I39ZXef2J7Njq//yDZ8mNn/wiW7LyCjruVTCj6U6irhpZE62f4smx6/bchd2vRT7tC2YqALXnfrQxpQy+rRVUuuKcro0T9ah5LT8PN761GLbWcw58r9uFn4Mrt+ADgbA8ygqQmA=
Received: from BN9PR03CA0722.namprd03.prod.outlook.com (2603:10b6:408:110::7)
 by PH7PR12MB7870.namprd12.prod.outlook.com (2603:10b6:510:27b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 05:26:11 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:408:110:cafe::a7) by BN9PR03CA0722.outlook.office365.com
 (2603:10b6:408:110::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.15 via Frontend Transport; Tue,
 19 Aug 2025 05:26:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Tue, 19 Aug 2025 05:26:11 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Aug
 2025 00:26:08 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Stanley.Yang@amd.com>,
 <YiPeng.Chai@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Check VF critical region before RAS poison
 injection
Date: Tue, 19 Aug 2025 13:25:48 +0800
Message-ID: <20250819052548.124897-2-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250819052548.124897-1-xiang.liu@amd.com>
References: <20250819052548.124897-1-xiang.liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|PH7PR12MB7870:EE_
X-MS-Office365-Filtering-Correlation-Id: 32967b1e-6f36-4b63-911a-08dddee0e878
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8hcT4bmXm6U0DZ+B5bVsmxYio3B52rUe7hALO5QIHpxGhAIJmZI5OtJy6+4T?=
 =?us-ascii?Q?xPsa7NX8cCxjXoBsrksGZ8wus0M5SbGBnRuufTVxIloYmi0McdXvkrUazS1G?=
 =?us-ascii?Q?i0w9thSJg3YwnEK//ZPM251t6M0d76FNI0N5j8rp/dcdp6Q9FshDSS6Qz1lO?=
 =?us-ascii?Q?XAWcZIZce9c9iBJZxCUYyZpznW+LLj/74whJX1zCg8PfuGpLAT/RU6R7dVQP?=
 =?us-ascii?Q?js0Fa2gMkNA2uFqeyxZoVOMY78xPbv3Nu+ndRCndlxQNsWT6Yic1awsPNTaV?=
 =?us-ascii?Q?ibvooe+XOmKqNwe38r5arfVXA2eLkPF+3ewopYoQEuDKSA2sAffrckZ/7kIp?=
 =?us-ascii?Q?hIuOm4CxJS7ZeolrxE8lX6DBt3GD4ySErjrKcQfazMObOzo3R3sVcRZOwLjG?=
 =?us-ascii?Q?AEErhelWc9G1W/8Vas7b3pjvCaCT7M/vWLi+coMX6W7f9ojg6vwSvFwRthHh?=
 =?us-ascii?Q?R6yDFSXJNG1ZXmWpjUBdlafLxDZc/MaafyiGr0Ap9H13UAaAgJ7hKxWK5QJh?=
 =?us-ascii?Q?5i/UwUwUyz2I8BGMwjB0fXEjugtOTGxMfbFHRslgEe5xNKnRm5++qK33ar8p?=
 =?us-ascii?Q?4+SptB+js/MknhDZjIMCWKkqlmSRIsZVYELWbsJ52xUTySuPYUHwkp/AMVjI?=
 =?us-ascii?Q?+YGs3+kZTMaKXW16nPJv9XudmPnknVq0TXWkwDcnVr2oRHad8f+dLyjSFe9A?=
 =?us-ascii?Q?Is5ZaB2jKowayLts953Cmf6N7sS17dHwL0dSFrM5RO8acOwTcq2LW/jT6mN3?=
 =?us-ascii?Q?Ho7L4cxSdCos7KWErpHjUbiD9QclyueM8LzQtgVEaquhP5FwlwZfHF6KBCGf?=
 =?us-ascii?Q?fC4FVnNdxlTaY4HIm5ThWtkT4cUYfH8S9fB6eKDDKkjLnDnSFIg9P9Pd1LFS?=
 =?us-ascii?Q?pg+bdrSRhGxPMQUHfaFNdC9Ps3A4n4lxPsNv3pH5X1muPtV/EwBAuQOBfQgl?=
 =?us-ascii?Q?t1mKxSVAjbfVR1CQm80xT4mPUc8r+Jt07hboffTFYmdGzISPljim3FKRVADb?=
 =?us-ascii?Q?VUp1ahQVvLJEWw6ZOtS7emMzRLXJIwHOSkST8LmZvzosyWzU3Ba+exZCfX3Z?=
 =?us-ascii?Q?KGLgK+YXAAMeqOBdUmxuiqM+7XKbd34Q22LPnWxKUwhFSZ09DwkocHNkd26Y?=
 =?us-ascii?Q?jMkCGEBMt5whlqF+Xgk0K5mhIbCPznJ97Fh9lDY85cvzWiaMma8T7dqmAjiL?=
 =?us-ascii?Q?DVWQOxaxRs0DIMj3ijyE7U5y/yubqnoL6Bo8lDwlBbvC6ldxAujh/8uqHUAf?=
 =?us-ascii?Q?ZdueQreGMNtelUKKKoF081FkW5iw92HlqtQo3fxDwRz20JEca+gRKis4Fn1H?=
 =?us-ascii?Q?aNIUv+L4Q3SU4S/G2obOQWzffVIZp+uKe9SptNLAP5sLk35R8LmTrYLlazxG?=
 =?us-ascii?Q?Suls1tfy6AC2BTLcPLjxaml17QaLfKamEK3vqL5XZJEgtdp3+fNbLOHXPX5a?=
 =?us-ascii?Q?j8xnTLbwNc1WSFmALcrqsw5Iyl0tPjtqlB5J6vDW1F58YYOnfcC5Vjy/FMnk?=
 =?us-ascii?Q?J6v+j97vbmBhf2erXkUlQLtADADXjuUyRBJS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 05:26:11.0309 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32967b1e-6f36-4b63-911a-08dddee0e878
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7870
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

Check VF critical region before RAS poison injection to ensure that the
poison injection will not hit the VF critical region.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index b00cbb927ca8..6730de574fdc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -219,10 +219,17 @@ static int amdgpu_check_address_validity(struct amdgpu_device *adev,
 	struct amdgpu_vram_block_info blk_info;
 	uint64_t page_pfns[32] = {0};
 	int i, ret, count;
+	bool hit = false;
 
 	if (amdgpu_ip_version(adev, UMC_HWIP, 0) < IP_VERSION(12, 0, 0))
 		return 0;
 
+	if (amdgpu_sriov_vf(adev)) {
+		if (amdgpu_virt_check_vf_critical_region(adev, address, &hit))
+			return -EPERM;
+		return hit ? -EACCES : 0;
+	}
+
 	if ((address >= adev->gmc.mc_vram_size) ||
 	    (address >= RAS_UMC_INJECT_ADDR_LIMIT))
 		return -EFAULT;
-- 
2.34.1

