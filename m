Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A98D3566C
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jan 2026 04:35:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD22A10E7C1;
	Thu, 29 Jan 2026 04:35:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iQ5ICKCh";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010008.outbound.protection.outlook.com [52.101.56.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9383210E7C1
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 04:35:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rE9uQwVL8a4MYZljmMXr8A+6OML5EGRVPGxo1CyZ4mjbeaIz0F01vhjO7nxme0R7/6s1eQ7QOV+b33kbij83ZFiJNNV2LJqAPWp+uQXnkhVoniwbMwV/e+SxUZ0LvkPKMXf7Fc1aqMeb7tudgMRBt0IjEHUrRTaJnYKhB7PPovXYqMTfrAwdiaaQdWDlvhi+GPonTwQootKYeSMjqcU2b/Rf0TL0y6+D1hveyJj+s2W//5GvGHRxgIkCbk7FUzr1Z9RXAgLVtadR6jJ9Yv+jQ22ykS3KwCJ67zcMEcI4EhBFZoKhe1Nc7iOY5XYN13n0zDxoe5mP2K0wkg3ujFWMHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lIhmgLLZwDd0aOqb8Q0jWswaBkAMpvKVDKg+fTStsrE=;
 b=HikSRCznUSFgvmWqw8CX2LNpuMgF0rSgt71ejsK4Ve6BChNELxb6wx0jkNQsC2ympGhzc698UodkVimOX0HAlaWNoI/2mCmGAozbaMQxa1cT6V1gc6sLflyt3mefqZLYlR4CKRmFbnhSZaimfrWSayOFHOlCkQwYGc6hIBIGxAKzdLLKCLFpNVsLrPQFJC358Zszb/S1ZC4Xn4IQhfJFcS77rdkvphjdDYDVBOLoQ3WVr9hF/ZjSwhrO/nbTXm/0/W7GNhMcYit+btLTllNdciA4xxVYvjZQ6IOT8o0re69u+VABCFRkeMdvwPbjRd5jlwpiPgY47vODYIO8HtuY6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIhmgLLZwDd0aOqb8Q0jWswaBkAMpvKVDKg+fTStsrE=;
 b=iQ5ICKChPHxD8JYjt/Ld5PrpsKp+Pa8pf8KIA60ICqUS7ZR8j0m4vB17kKKXFOzeKA47R7oLAkNEz6SqzJ7VK3GPNiedYw9rqTUZLwLm4j32bnog8Xxz10WWcfjxp7NiTferUAYYpDwz1F2+FkIBvLEqm4d4JStE9jGe3n94iMg=
Received: from SJ0PR13CA0213.namprd13.prod.outlook.com (2603:10b6:a03:2c1::8)
 by PH8PR12MB6746.namprd12.prod.outlook.com (2603:10b6:510:1c1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 04:34:57 +0000
Received: from BY1PEPF0001AE1C.namprd04.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::af) by SJ0PR13CA0213.outlook.office365.com
 (2603:10b6:a03:2c1::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Thu,
 29 Jan 2026 04:34:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE1C.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 29 Jan 2026 04:34:57 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 28 Jan
 2026 22:34:55 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 28 Jan 2026 22:34:55 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/3] drm/amdgpu/gfx11: fix wptr reset in KGQ init
Date: Wed, 28 Jan 2026 23:34:45 -0500
Message-ID: <20260129043446.33377-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129043446.33377-1-alexander.deucher@amd.com>
References: <20260129043446.33377-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1C:EE_|PH8PR12MB6746:EE_
X-MS-Office365-Filtering-Correlation-Id: 00d3d422-3366-4934-7400-08de5eefc1eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AxxYE10GL/HJowvDk/iuP00uZEYUhaleAz44IOXkrwK7hqDcpBY8NMbkTjNg?=
 =?us-ascii?Q?QhVkbwnKRQIimEVkh7/Qr+ODv/ILDyx+kTHs/echfbn7WwGOdrZR7rusfSWl?=
 =?us-ascii?Q?BEac7Zc6XWJUT/5Dip5SlkWJKwGhwvOx+B4njE72NZ/sms+d2U0U7wIYUwdR?=
 =?us-ascii?Q?AZS1N6x4ortE9kKHPyZcD9f8rw/qJjve7ZNIZlsBAtCYUDXk2YRDMy/aF4BA?=
 =?us-ascii?Q?4mKD4YEVsHCY7zhl73yY3Y76uMOQGOZ469yTrASFN/St0WwTGPX1FkYSe0yh?=
 =?us-ascii?Q?lHdBVR4KwFFFIve1M4QAF56kYkC6VWeCEKQwHiOL1uCjmPgWZ1f1MjKqZf7u?=
 =?us-ascii?Q?KxyNwW32Mqa+0FHFLffH6YXGWOLrcQO38GDM2Q4j9dPSiv5Fh8nvNXBzaPgY?=
 =?us-ascii?Q?hj/ZgGOnCYN+WtdkzWc/5dh5UjvEhpDX+Xd5X7enuFEM8/6ENEQMqVhizbZ/?=
 =?us-ascii?Q?woa3Vjy6A1pDluBsdEP+jX4kg5hkfKQz1CYgK9DuVKGbT04TrFu+/PRXnF80?=
 =?us-ascii?Q?BKZOSQ3ELEri/fyUjb+6ViZuRgfDB+2L6oSdm8Bvf1Lt28RzD14JdBGUHQ++?=
 =?us-ascii?Q?5uiDeLMStfW4fIfU+a5aCZQS1H6BTHFYe9jHeUSCIMnipL3BgbpIPVcqvrm8?=
 =?us-ascii?Q?JuXdGOmOGNW9d82isABpG7XhxgCxGD0cGYz8fxLMIl0QZtG4uaX+WsbpKU8C?=
 =?us-ascii?Q?dcVf40argc8ICrFi50e4+44B7iIJ1m4W2X+OWqbGGgWKa+z6TdR0ZZj9CnFW?=
 =?us-ascii?Q?ljShebv9FNq5wjn5PRPdq7ch7fMoTCiLs+9/XlX4VSm1UBq9K9uY+0GeB+Vy?=
 =?us-ascii?Q?5JGpkdPyCbiwj6CfIyFaPWEC4Gln6MJ7Ft8W8yWaHqROi9mlh6fjx0xgachX?=
 =?us-ascii?Q?9xStjxcQ5lItacwUk+2GSEOgkj1NTPatZJwQiRkE16OqviT75WItH1u3KIui?=
 =?us-ascii?Q?4Nm3onzgT60BWx1AEmLVtMUdcoo8PRrpYBhhSApsqJWGr76Zl749qSh1u7Wl?=
 =?us-ascii?Q?csZRKLqbqQ4fI7JL6ZpfCJhZziJZNJL9vKjAkdgQjmNm9akZukrPR4n7TGlF?=
 =?us-ascii?Q?TASiXEqkGGxSXVVrUMkMmoM1ulMHD5w/2iaQe/u1hADqskgQPIdQp0nKRTVJ?=
 =?us-ascii?Q?KZRMCXVeGT5a3VA6vk1nosb7b8YCajjMCE0MLN7EZDzY0oxvFOnkImwNPGCu?=
 =?us-ascii?Q?p8UpBjWIFJG30TVjU8MTqU+uSiyFB6kTa3+Fz4n08nxna+V831b10Xw1OKQ0?=
 =?us-ascii?Q?4/oUJmCDdK01AJweKJvpe2oVy11tfy6aA3fTuRoCw8jbsxzSCukMCaEVkFKs?=
 =?us-ascii?Q?sBXZ+DhCs331VG6Bl8mVrJdyq5NfYzynl9XYMu5Jhpo33dF31Frb7Nnzt0ps?=
 =?us-ascii?Q?W3DWSOJBSjt2AkaedEka81uqw6lKdbXmWoI6gwf5JFwKHjp5OLX52Bbu07sX?=
 =?us-ascii?Q?24tTy2CRPmcweZ9WypkBEcuZpbIGkyToK+cbTRZLsy3iJVURhUjjJ1w3SApC?=
 =?us-ascii?Q?rY6LE+YEll1CuwSE4MOshcF+t9J08a9PphjgxyizSdHzvdpzCcsVOUsXUgzD?=
 =?us-ascii?Q?ayfYeD8oBeEXwXdhBFDLL7DUtMSqU6wDD8+v95Tgjnsc32Dcgym7EHa/94+G?=
 =?us-ascii?Q?wMx/4Y7DSwdB90ttX6U98erx/j/dIpIKyozIODTmJ/WWKNSIkc1rcVDEUavx?=
 =?us-ascii?Q?RORYQA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 04:34:57.4815 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d3d422-3366-4934-7400-08de5eefc1eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6746
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

wptr is a 64 bit value and we need to update the
full value, not just 32 bits. Align with what we
already do for KCQs.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 6145cfc0334b2..b5a2d09fc3469 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4224,7 +4224,7 @@ static int gfx_v11_0_kgq_init_queue(struct amdgpu_ring *ring, bool reset)
 			memcpy_toio(mqd, adev->gfx.me.mqd_backup[mqd_idx], sizeof(*mqd));
 		/* reset the ring */
 		ring->wptr = 0;
-		*ring->wptr_cpu_addr = 0;
+		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, 0);
 		amdgpu_ring_clear_ring(ring);
 	}
 
-- 
2.52.0

