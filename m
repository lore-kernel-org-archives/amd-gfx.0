Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD88CAC59F
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 01:36:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E05810E5FA;
	Thu, 18 Sep 2025 01:36:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TqQR9Vhy";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012023.outbound.protection.outlook.com
 [40.93.195.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B13C610E5FA
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 01:36:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rplcBIALfJxgD8HZQUEwzXjvV1CYocwVvbIJXiOtuau8ODfjXMg7v9etEy9IO52sHzc/Jdh8dAN/44mI92O9J99Ghre3iiqsDHHnOiEmyIgb1wskcrvdRpZh+Yjm/eocp0O9SY9Mjpgqqrb1kWYuFXLwR3aWYXutyZnIC/0ibLgcPo8Phj8MQbJViGun0mjOY8xKkNkf4CehgAQwAKx2EQcFnCWcUHufFUK0VKKgdlEKmo4YEI135wRpaMEy1s4DC8+AHCZDh+Pz67NVDdiS37MsSm+a66A3cmckHHHUK5CBUSlrITafp3oaggbLrA0tRrNaBGEJr+/Vuzvh+HF7qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=llkaKf5Gqpi8SBzmX9Fv4JhdexshSL4hK7Nr4hDlqEc=;
 b=DopT3VtmGaLtTpKHtt1BZ7DMg6Jch8aiD6v7xrngKgB9ZtdaMyM1Mw+ULtcWOFA6Obvf48ML7iKyDR+KBGl9r8c/9/SkfiucOzyImoObErC0f/BI/iWEAevSKhV26LI6qeZ+lKH4R840846EQRdcAv3xKwnGYbau7dPbs+UGPQmZIP4b5Bb7hwUh6+bVb62GNl0S82AKAXr4WyvNpRFgQq+z6byo0RETAhB8YOvCiTBMInY+DgUewYN7l9C6cZtQIBnjpOKqHpskut2s/WzyISFFRcIYpH4hHZ3H+2Ekjh/XxuTLJ1uadcbcDNXNio+K3B9NittihLJsCVgDXfr7OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=llkaKf5Gqpi8SBzmX9Fv4JhdexshSL4hK7Nr4hDlqEc=;
 b=TqQR9Vhymft2oEQuXtcCZ+IiwcaLAWbjOd9oGm6pxn1mqNJe0UGxXXPAplvq+mvZVze/JLJY/jikCoC7waXWm5p9ti3uA08TM1nqoge9qF3Hmr66eAXutr6M4C4QbKADNzOxe3x3ovc96g7XuTWhluYwNh322eCtEwh9w3okT7o=
Received: from SN6PR08CA0029.namprd08.prod.outlook.com (2603:10b6:805:66::42)
 by LV3PR12MB9141.namprd12.prod.outlook.com (2603:10b6:408:1a7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 01:36:44 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:805:66:cafe::f7) by SN6PR08CA0029.outlook.office365.com
 (2603:10b6:805:66::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.21 via Frontend Transport; Thu,
 18 Sep 2025 01:36:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 01:36:43 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Sep
 2025 18:36:41 -0700
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <Stanley.Yang@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou
 <tao.zhou1@amd.com>
Subject: [PATCH 01/10] drm/amd/ras: Add amdgpu ras manager folder
Date: Thu, 18 Sep 2025 09:34:58 +0800
Message-ID: <20250918013507.2629620-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|LV3PR12MB9141:EE_
X-MS-Office365-Filtering-Correlation-Id: a561d1aa-5a83-4c8c-99ab-08ddf653d2c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vURpbf0w0RyTXhWRQ2212m7IkK6Xt+w6iZ/4EhB8M/cgDiWdZTJqHh1q9xLx?=
 =?us-ascii?Q?ben1CqBdm4ZINAMGG8B3ATSLLLKiqU+kHoTWVjBunOEyd46oxtElKY4O9zWU?=
 =?us-ascii?Q?5BIB8EYoUlNPSU6cxXrxXrWvBFB3VdIvrCr2uEmfwwKB0/d8iQckrDWjsuw8?=
 =?us-ascii?Q?gGIkzzRMJfFX7RCfu8kpaLV9a03tbm/vFEVxRCKnBcIr/dNVORhRYfbFDJwZ?=
 =?us-ascii?Q?WLBdD0xVk+lJwCd72iLbPTYJn6Uiz8Uja7LkTM86Xoa7vhmCpnVRWJgyLDAa?=
 =?us-ascii?Q?kqZ7LDLvO4IuJZrn8amXxvbzpfw1r0ikukPjFbkj5icdCtmxa3Bt+tUVRnK9?=
 =?us-ascii?Q?0OdaWMzAtJPSdyGY9CsqX+h7d5Dv7OsykFWs4ONz9oip95QQqJc3kjesYL+s?=
 =?us-ascii?Q?dFf2N5qr7StNcPlIDnV0njI1NJGRC2ArOWxKwxc+z2nZ0Ck6nXGRzd5oWDwi?=
 =?us-ascii?Q?WwOgDRjLNy6lfrG0tcCAL5oabnK7Ay8Dp9Up8cnaOukkJpS9SqaSHaMqdUvo?=
 =?us-ascii?Q?4lRLLY0xs+dn2KHeleWIC9bscKEjORIpdG4U+xtoRVjwoTqT0KtDR0sKCLOt?=
 =?us-ascii?Q?GzWHz1X788bO5xn1CVhgKxOCvkGTxMcTh/czNDZcnQEM+J62UTme1NG0epNV?=
 =?us-ascii?Q?0i4XzRBz6pAujNFiqYUfRraSNizT5haDMjkCr1mKk27oJQKMAQ1QcVthUR+j?=
 =?us-ascii?Q?dEMO2pzXh88df1raNhK1UP+Q2N6BOS+tfSrtkfPNWFjQSPBGGx3Pi2jfGltx?=
 =?us-ascii?Q?9J+BOIUz/QnwIgKq+GlosY5+CkgQspZqwD3zr+uBnvDxvqeezZhaxDuFz4hZ?=
 =?us-ascii?Q?SB8DvLJIHUuGRRQiaAqc7NKfbgOeHOG4REEeFD2hJfcCA1RetEgSCImokxsE?=
 =?us-ascii?Q?bhPg3+nbixEYtoL3MJ89xN1UHa5fFhdmnRx2ujBI+kGfccGOtq/2ic+at95B?=
 =?us-ascii?Q?5yqZSvxFYdkgp1EMSgJmO3plEIT4aAKrCHau7sLFy40D+fThb3AlDSwhkQBt?=
 =?us-ascii?Q?2LtPcDMbyB15ylUVG7qYta2HhzLJtQuMFuL/GOx5Dy1J6MmN1wZx52YYlQcJ?=
 =?us-ascii?Q?91IsGvDzexw9o9iflEGTQy573xjdu2sAUva7r33w7eit8l6AX7cH8IVgxckc?=
 =?us-ascii?Q?f3YYUIBV5/TTvQnrfkpI8KLIxqSRoaUiY6av8abk1IfJpZd+nHoAuWokHpWl?=
 =?us-ascii?Q?0iEp195tmd9OPEnERng4oi0yuJOK/LqtrUxuCzGoomVhXO0Uyx6celp3njLj?=
 =?us-ascii?Q?jrYI75IWT3Y1D0LVheJhEOlN7o2EsT/9Rt8lofjCs7LuM3NG0l2MCGjuEx45?=
 =?us-ascii?Q?rbsC7fiVjbp7A5GOK6ruuFOQqc7Tm7+V5ZRlUy4nZV9vudy3jgFKbKgVa7ZS?=
 =?us-ascii?Q?OX2OiU9BNnoE4S8YP6JH8oK4sjjiaGFjDvPVmmkzA7X/dhNvFAYuIcWscy0i?=
 =?us-ascii?Q?z3BnYQTHUOgHfIpwIRCykuEJk3o/77qyjADzGXYi4Ix74IFZTah5xyxE37u6?=
 =?us-ascii?Q?im0+U6GmfNY22zm2EPUwdtAQ+gStxFuQljph?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 01:36:43.4099 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a561d1aa-5a83-4c8c-99ab-08ddf653d2c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9141
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

Add amdgpu ras manager folder.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/ras/ras_mgr/Makefile | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/ras/ras_mgr/Makefile

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/Makefile b/drivers/gpu/drm/amd/ras/ras_mgr/Makefile
new file mode 100644
index 000000000000..e69de29bb2d1
-- 
2.34.1

