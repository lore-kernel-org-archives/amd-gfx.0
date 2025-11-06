Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B6C3CCFA05
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 15:49:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1FF210E943;
	Thu,  6 Nov 2025 15:49:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xn+Yz04N";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012046.outbound.protection.outlook.com [52.101.48.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C728C10E943
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 15:49:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IPJqQOAYPyc2XkxK2nVuUzCvk/Z8WvAb1cPOH+BVoXMHCxwDJ4onsasY84KS4vDUTLHKHM5QwZQJX6ew8SX3mS4S3KHP0TwgiwWGdxkm1HbgcEE8t82kV7L0AlH+FpB2QfLttcwEBahGAxpxjFIGqHev7kG2cTxqmLOMZoz87S5ulgk21NpdjcBQuvD1NfbonWZftLUOzxDNhoRLwtRn+1tt6LD2YOV6YkOR661APSiP7VArN6QrjKK6gIFGDFez23TbJtqpMUExhOlgIvDw2yavOU/hb7uz7hftl3eR4u+/yRBdN4ZId4/Uj3GjSjfXLEdEsgiQ7mR0TmWHcVxpXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DwJkT5FLH2YowtPBXv6+Ji2fpkN82HZjhpYG3iokxX4=;
 b=C0FQK6A+j6SdlMU/TwJ15gZ7411N6QMzhOfeig1PhHWvKdBxBW0mUoE5Yf/nTs8aQ6AanF1X0Pny/2GJeB4TxIx9oiTapR/Ef6ww+g1BY6EK/GbT+W6i9wsAO5HgHKwq/cvUVODgntqPe8bG/ehlVXKMjNUSwK48y3f5bHWwp1YGSExJ8rUDNYIcSC26y7or2zn1wN8JP2akLVx+2RTacfhpNaFCuLRgjrCQYgWoaiM/5pHgnbkvUVmCJMvPloDsYsjMKpNDUSYcDwSjU7fFzptgwUzERoPIBaAwpv6waemDPo9fplqbMVEBHFO0Zgd7IiTWEAC9oDQfoIKuTTCtpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwJkT5FLH2YowtPBXv6+Ji2fpkN82HZjhpYG3iokxX4=;
 b=Xn+Yz04N5KGAwC+ugCX4XsSu1epgQ8cn5SzePEEaHkPHcAJ0Rz0n+i7pPjG/0P9XKh/OrdvKj4to3tt02kqyHIyRCvYRk5TkwddXB/i6PNEPnCFoeqDVW+a2N5yKrvs/6aQ+A2DkpG5axQa0oumcSl8EReo9uQsXJ8KUJaqLmhk=
Received: from BY3PR03CA0010.namprd03.prod.outlook.com (2603:10b6:a03:39a::15)
 by PH7PR12MB6955.namprd12.prod.outlook.com (2603:10b6:510:1b8::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Thu, 6 Nov
 2025 15:49:32 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::a7) by BY3PR03CA0010.outlook.office365.com
 (2603:10b6:a03:39a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Thu,
 6 Nov 2025 15:49:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 15:49:31 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 6 Nov
 2025 07:49:28 -0800
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <asad.kamal@amd.com>,
 <KevinYang.Wang@amd.com>
Subject: [PATCH] drm/amd/pm: Add NULL check for power limit
Date: Thu, 6 Nov 2025 23:49:16 +0800
Message-ID: <20251106154916.3783877-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|PH7PR12MB6955:EE_
X-MS-Office365-Filtering-Correlation-Id: 4da69309-f4c8-4055-0c48-08de1d4c139e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YgXwxBYGiKt+yUvJdIS47So915pafICnUwagTFmgWxHMKOK0mEnW+A0WQGvN?=
 =?us-ascii?Q?zU/E+gyks2uZe+qA7sLDa76HWqrcfcWMFaXYMObffFGxYvls1Di7njjehNss?=
 =?us-ascii?Q?a0E93UDHCmy8JPBKsk0N8pgirsVLddWBuGjtMfrdstweHZYfJOF8wTFfZtn3?=
 =?us-ascii?Q?oQ3o8L17KnpkLj78cm0/pTGdOPs/aT/pfhQAqksMCEG36w1IXnjt04zg1v4x?=
 =?us-ascii?Q?VtLW7YKSiDDL30VOYFucd0W9leOnKmwIy82JCpfUOY+CXSVMnK4m0m3sxtJ3?=
 =?us-ascii?Q?hdH+eHwT1t6rp4/cPnBo5L3QpL92cKlAH4sQGreErD5otItcQZgnc2ouPE5r?=
 =?us-ascii?Q?ANriwB/Oiir2Iu5KZhgVVnMeFZIrMuoGJAVlmnOQdaruyyKDr/eywORPKXsU?=
 =?us-ascii?Q?xeh8ytleu07oQh5bS84guH+7zcmLBY9KPWqvtQS5nDXiHDNoHfZgtYAPZUhT?=
 =?us-ascii?Q?o5P8GB6vibvM5qnkiOYzQzXBqCTdr2SKs16rKgSTz2Fb656GajUguVKTilcs?=
 =?us-ascii?Q?2IgLm19Y+VvBAebvNpLlVJwNfzlP0S4AwkENDDTFGp4yE69QCzG6yFVqgSJc?=
 =?us-ascii?Q?c0M5SghJ1fZf6T7gVzUc6qQ4TFbqMbn0awXl/1WVzD/ZuMkQzDs0ONr4aHLL?=
 =?us-ascii?Q?I9WFIGsoxM5kW7J9qtkqJy/tGjSocc4N4UNZRngpu1AjP21ygurySKlxiV82?=
 =?us-ascii?Q?SzA1QR+J8wsWkh8JW06dZN6ix+CsGVJCA2V9xzWOP/d1b6ID5ssrao3WWf49?=
 =?us-ascii?Q?BlJwsCdNTREvexxpkdz3m+CHmHgJYDyVpHWWL+H3QeDrCu0S52Xc311jQMQ8?=
 =?us-ascii?Q?JhIZ1cdBWXSZalEdsynC7Aq9LuaPk8CwZ+Fr2x0OFqeUrrhL66w8jqnWKEu0?=
 =?us-ascii?Q?eUfoZZ14DYmimltYLIvDExnL5gM/rfsyA1IiRKh6hsHLFd4TTJIQD/BHYMWF?=
 =?us-ascii?Q?00Zo0sSBNAK/iH4tsXcgdFKAUBChT5OfbpzUyIZl/Gzlqh5J10Q/bM/Y2Ihy?=
 =?us-ascii?Q?4BD+FBXGPfeDzA+fpuYpRrCuhoCAXChqcU3CfeLD4/UHNY3cZc/Cx19RrYsp?=
 =?us-ascii?Q?anXIn/Yy+nRhmHlZnjivEWDWcqT1vDF/iapw5/Nbf3E9Kmlzed+LuX42q6RO?=
 =?us-ascii?Q?0tJ4dggkqUu7lKp7ySLnt98kMP+q1b9DhbWGdsM4XmOr2UPNh82CCKQz9FSX?=
 =?us-ascii?Q?9R085Xxb8GaIB+UkPi3+/rP9gKxQfcqwyzUd4fxFyP0GCI9RwchdwwdMXS7E?=
 =?us-ascii?Q?Q1PMGjfCVdcIAyt7XycGKs1IRHhugfJz2iGCuCNWG1GOrkM3ZlEem4f7qeEA?=
 =?us-ascii?Q?4s9CE+zEbRVFJ+52dCVb7aAz+q1FqIp4xfEHlDGvAwfTacdKMpG5jgmy4tl1?=
 =?us-ascii?Q?E5iOAv6FycYkKKYoWprOcHTyKLi6WKWeGlyW9ro2pxffT1c6xZc0dDTLv2GY?=
 =?us-ascii?Q?QM1h+sgAbOJP40dTvcYvwLYV/RhZkqy1cSt4Fnd8SMaQ807AWTgpk+oaZJ9p?=
 =?us-ascii?Q?7wbls9eBYk6UcPZPTHxp03FgsMIU6VX/qoVir8oGIjsTgxwJS4ZoAtJF1YqE?=
 =?us-ascii?Q?7sFQiCYWZiO2QuKIses=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 15:49:31.5690 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4da69309-f4c8-4055-0c48-08de1d4c139e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6955
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

Add NULL check for smu power limit pointer

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 8b49fb86c77b..835e9c9da521 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2907,6 +2907,9 @@ int smu_get_power_limit(void *handle,
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
+	if  (!limit)
+		return -ENOMEM;
+
 	switch (pp_power_type) {
 	case PP_PWR_TYPE_SUSTAINED:
 		limit_type = SMU_DEFAULT_PPT_LIMIT;
-- 
2.46.0

