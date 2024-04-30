Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4166C10F16
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 20:36:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23776112F34;
	Tue, 30 Apr 2024 20:36:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3mxlTVZZ";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33319112F34
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 20:36:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=no62H5salJKn9e/6okit7tCF4fiVnNcUAIsxmwU8m+fJVNeuhJrENQJz3JkK/xsra7zxp+myefc1h6miCdc9WCUUg+ZBekM27yAbRDUTZEevXDJuX4MNDxkezTvSW9ykZ4CoPghcZ4myC/P3UOnRmrav6NqxnsIHMPM3umkGzBstJUvSMM4roED2ZIHj7gAIBkfusinxU17XKgWG1fi0rUtGCTBhjUyfrwAmruTS6ot+3dwjGJPqbjUpg4mlmbFHcicrLCiFShjIfC9Te2KVKqDAbSAmjECjiBgJv9sHxVDIZUl8TccH3vdBybTv5ELLwL490t1N3a8XitCwRjl78Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TlUyBgTIzZyRPZNkrYYaQOViix2lhRpf7KkZrd7CTho=;
 b=C/28uhHdcw2ur0FjnuRGRucvx9fEeMx3mMAP9zIUlM7fJf1fRMvhKL4ttCNw8n2BfA/QZegRfac8oD4WNZNH9EUg8tfyRIniGeGDHKmNM4pb5FGWBBZF3S+9Ag6rkeCZuaz0XFHc/AyxRwMf5akhFfPnLApt3r1DAZFuj4hULbMG6lLAK3ME0JXuEfxVAt3glU0U5rYauEC9dGmGkbdnLgt1EweJhmdcJyEVR+iXF4IByJeRivf83OGY3M4PNJ7qGxIaUmbt7PfyrgmkPAEMP3x1L/VhCMs2fhW0aAq5ZurHHslojuwzRVU/BfoUBwUHlSgrxt/NqWR5bhutT1pM/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TlUyBgTIzZyRPZNkrYYaQOViix2lhRpf7KkZrd7CTho=;
 b=3mxlTVZZNcfT+0hEEe2RGSMGf2d6QnougncW5l83u0ksbzqG6iYDaPYxziZvRTQUzyXHusQHjNvIrJlqfjrqdXalAqRLDgpEvu9xBz2ijUp+fEdvC4B8IayjYYKFU2XNtG4Mxb56aoG5dCRgH8hR4j4++hyQKzWI+vvtFfoOABs=
Received: from SJ0PR03CA0227.namprd03.prod.outlook.com (2603:10b6:a03:39f::22)
 by LV2PR12MB5871.namprd12.prod.outlook.com (2603:10b6:408:174::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 20:36:25 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:a03:39f:cafe::51) by SJ0PR03CA0227.outlook.office365.com
 (2603:10b6:a03:39f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.42 via Frontend
 Transport; Tue, 30 Apr 2024 20:36:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 20:36:24 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Apr
 2024 15:36:22 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/3] drm/amdgpu/mes12: increase mes submission timeout
Date: Tue, 30 Apr 2024 16:36:08 -0400
Message-ID: <20240430203609.799792-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430203609.799792-1-alexander.deucher@amd.com>
References: <20240430203609.799792-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|LV2PR12MB5871:EE_
X-MS-Office365-Filtering-Correlation-Id: 19c13ab1-a786-490a-61e8-08dc695533e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400014|36860700004|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MVejWDERKCAuooxKQ6gCW1tHaHO7XsfkmaV7uOvw89FtyjKN6uh7/MeTc/+J?=
 =?us-ascii?Q?VMeZjeEeJXSNuFMmcZeOkRkgoMLkORb6fd+jXOC53xYb8CJ8oiTWZ7HBftXv?=
 =?us-ascii?Q?LvZ5AqQAgJc3n0OQqtazJwysAgfaSb2vmhKvxk8Td7EvqgA48k5yombVd7jZ?=
 =?us-ascii?Q?TZjXpjpGMRD/5SvgCZCwrIvgDCwJyYL93uNH4xWcyntdB2+iUmS4gtria1iA?=
 =?us-ascii?Q?FlorrZ7MMgFLfOhYfIH8ATUlNxai2ZxfW8TEku60WCzUC9Bf8D0PToFu8bz+?=
 =?us-ascii?Q?R+wc6HErqU45hdQFI+X3bMeG1GDUE1Jh3nYTkUTTnEDwPQ7vzTYat5aPyonv?=
 =?us-ascii?Q?gaKlna7TKVn/I6v3fXskW1CUPo35+3fOUowymqUEY8GxRNQEcA57v8eNXtYN?=
 =?us-ascii?Q?wxIrB1uIvJIXhFYY96RfJNCXrSMH2q1s7tZMrsU4OwKhQelfvUWFefg1XEan?=
 =?us-ascii?Q?IY2uAmCENNDuwLUg7YZZFZJA5Rrpu0FWhiRybPXoI4G8YA1gzuyVol/KHwm3?=
 =?us-ascii?Q?IqsnhU+3tSLyOBx36jtTfjHmhuWBlHfpFf1ruFWS7HdUU5UPTKkulMrPZr1V?=
 =?us-ascii?Q?YAH7s8qwTy07KDxjE9GbQ3OW1gR8AxXE0D6z19ZCgySCIonsn3zFMcpwd63o?=
 =?us-ascii?Q?Rnk9iBvwxO5ZAktwvD8hN6v0hHNF+Zklgm7Fi5xpH55pXwhiohxLLtrf4Gkb?=
 =?us-ascii?Q?rKyfFfNg6LllxlIKUpPzDPQreXx95dCncgW+bliM17SfA6vHrHpfAar9bJB5?=
 =?us-ascii?Q?ykthwab5QU0MLQOIOS6VhxJWOZQLwkZpw80Ue+pZVyaXSr7/Kxec9rKn9gs/?=
 =?us-ascii?Q?7tREIP36PqIZVFKvCTFqe8+nEjUBRZoFdBVxa4orzDNRGVRzzXTNXcca1uPD?=
 =?us-ascii?Q?U46dxV2E/yeLbWrptmcN7Qw092u+NMXLSoFdJktA2eYXaC5hyf1XdkV3VatL?=
 =?us-ascii?Q?gE49XdQi+Wk4KNyKJ5KajpdApAj34Gs6fAc6eRPUSOZK2baYgE8lBLMe0/xC?=
 =?us-ascii?Q?3QLgyRdsrrXFmmU9q8xUV52f5GMEBAgYjUqVlLqQyHyxVLirjbAGqae+4N00?=
 =?us-ascii?Q?A12bgLYOX9FcTLyI8X2g2MTDHEJbWo1h4DPNxgTdPk4Sox4udEjJn49+0RQ3?=
 =?us-ascii?Q?OCGGnZWyd4C0G7Rns0w1dx50kNQMb+3Z+hfEk8G7d8T62LQNG6KniczGgSvL?=
 =?us-ascii?Q?DU3By17kmnAb+hRAM3XBPTffvO+9q4YhQT2IjwvvcQsFXJl6CURw/nsZLb9F?=
 =?us-ascii?Q?5VOjevkb47Wn1C2HOxkKuR1mhetgJNGlzNx5ZpUIP+WyjKDB5mwqgSBDHa+W?=
 =?us-ascii?Q?KA7nrACP+AwMGYc6ZJEyKfcesiqkSXLLaoSM+v/7aGWgxqIxfowtt+mC3YY2?=
 =?us-ascii?Q?9Osl8aW8NMCbPPNMwWX2+IfaDIxF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 20:36:24.2143 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c13ab1-a786-490a-61e8-08dc695533e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5871
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

MES internally has a timeout allowance of 2 seconds.
Increase driver timeout to 3 seconds to be safe.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 9385ee76f3e6b..57bc277677ed6 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -151,8 +151,8 @@ static int mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	struct amdgpu_device *adev = mes->adev;
 	struct amdgpu_ring *ring = &mes->ring;
 	unsigned long flags;
-	signed long timeout = adev->usec_timeout;
 	const char *op_str, *misc_op_str;
+	signed long timeout = 3000000; /* 3000 ms */
 
 	if (x_pkt->header.opcode >= MES_SCH_API_MAX)
 		return -EINVAL;
-- 
2.44.0

