Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2845BCCF9EB
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 11:50:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1D1710E0BF;
	Wed, 29 Oct 2025 11:50:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EYvCc59d";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013014.outbound.protection.outlook.com
 [40.107.201.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB12810E0BF
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 11:50:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GIbt/AQd98MHIK2HfTu3KqW+jhvBWLL0H/n++l3nGEalyDFj/20P6+C7Cs8eupS9tH+2/n01zCxzb4weZ+6yo28WMDtOZMlyf6nk489fi0GnlVEkr0uCI1uog5Xu23tDRdIE3kNP5OiCzr6Xai4eFteETXOSXKFC412/uLgvt9QcKNE3N8Rh7Z8S5kyU2nO0VpTKZh45MNX4zn5pweoqoZr27cPmsteoPz2JiBPD/dXCh8Bv81h0rYXCp03iDLDlz48W4Qwpse/06GU/ROqPiHRNHhOaQtFfhYgeZ5aEQq/KdTLDCSPI3tEvW+s+AdDH36pqmQKOymcbeIaiFyEoAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4HMi0olKBaEKStLEWJaBUz9zZIJyyyls6pI5gnN4eZk=;
 b=jOgvbUrK4Ro37wxXAUIasrCWp2lqmKOe7ER8TPoCyYj39+jy3tFY1HimlYVVnbXJGfbXXoUYFoJgFAOvMNVh9U76GlG3cNpboIVhUy5hXUYogx56csWJ+Xh0kIPU/bAk6+3udxKTRf1rz5qp2iSo2ky0fM/yFjcchrqCUPnefFye5rFqD3D6zY0mAN8mGMekFz0VBDKK6R3yZJYZmKW4pDIxUIG2ebJDgHQ5cIkGOhQ7uM6d1cVeh1SZtD5AmGLSB7bpHwi1lO67bWs/quc/RlIn1D20SN4KqtyWzLCIHpW4PgVlO0dq3fOYAwIu/i0PsT8J6++o+9zDhSCCNnkrUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4HMi0olKBaEKStLEWJaBUz9zZIJyyyls6pI5gnN4eZk=;
 b=EYvCc59dn9AFpSuUUJOKOtWFSUQlouPvgnCZIt8jwMUzw5MHfVXGAzYgtE6wjTKhx5wtkuwh/2NtHzYqV2D9MUtzKkwCF4by3Oyr+ZqAuuTq7b/ac8o0xkTPEvxRKGYbG/0pkPb9Z8f2tF/5KLawQWBiY2s/2mPCvxTf4xE5/yg=
Received: from BN9PR03CA0098.namprd03.prod.outlook.com (2603:10b6:408:fd::13)
 by MW4PR12MB6974.namprd12.prod.outlook.com (2603:10b6:303:207::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Wed, 29 Oct
 2025 11:49:56 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:408:fd:cafe::97) by BN9PR03CA0098.outlook.office365.com
 (2603:10b6:408:fd::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 11:49:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 11:49:55 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 04:49:50 -0700
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>, <Jinzhou.Su@amd.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>
Subject: [PATCH] drm/amdgpu: Fix error injection parameter error
Date: Wed, 29 Oct 2025 19:49:20 +0800
Message-ID: <20251029114920.2119384-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|MW4PR12MB6974:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b0abdc3-e1c6-45aa-c5fd-08de16e1477a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oeamJQln6SJJ/1sHyy0Dk6mP0zJOoCCkAjt1nxjINS/luZ8hLvSAE66fm1+B?=
 =?us-ascii?Q?4tOIQ9aJTF+MnTAZphxPABqV3Dr5dt0+OySWMlBO5rp1jDVmOb9/lILQdvQX?=
 =?us-ascii?Q?+yTNtOxI4Z5+5wheyP7nM3/4jc3BVnKS+PwVIwKg4q+WLyQMhFevr0gcxgiu?=
 =?us-ascii?Q?OwAD2B/31sQ4mH090JRdFd+B394Ykvf+vPmBzb/vvHtnCl032FZG8z8wYrKc?=
 =?us-ascii?Q?EKtcw2GFR4y1+8Q4IQXM/FHSWTj3DFwdX3pIwk4Z4Z+d2LOg5MQ2Y7iBgppP?=
 =?us-ascii?Q?wKRVneiO2p0pUwd1Ndmp4I4iknWP6c1YOup5u+crRCFM6biv4l79RKd/FmUD?=
 =?us-ascii?Q?bvQu/pu95FbEPtldNW+DNj2cDy7IAkW46uInqt82Ow0jzLEDELfTKgYyY9xU?=
 =?us-ascii?Q?tEyAijgTi1uo3W9sjRtJ+no+2ksVRGY6yKJG56LpG5ZsGQ6Xsf5hGKpVtuCs?=
 =?us-ascii?Q?Mja51HlgI3NcY9by5oIdyemmOPN9fY25EEb7DUaXSJeTkvFoXm438KaP137Z?=
 =?us-ascii?Q?saKx11PC+T3bjcyC+KyhWquf161W4kYLS0nfYefig35/QgrRGeykuooAKORC?=
 =?us-ascii?Q?bRAIwD3J6PKp8xooMJCCQiBsyVzMTWrIN0LlxmJ82pL7dP/b65ALFmgQnmxN?=
 =?us-ascii?Q?dd2QeD5dNjrBus607HXZ+IczdyFJTl5aGuD3eSISTRRtVkq+HEn9RyqSaUxh?=
 =?us-ascii?Q?qPVbA3LqrUjzUdhLzHTUKUFXqMPSXZraVcRPJw9W1+jCDf1FVKGUOFhs3AoJ?=
 =?us-ascii?Q?vuJOYrRsQkjAYIzJDNdvkZKIceuelRyG3JTOCsxGv5DLGqWUPByAD+RyM8cU?=
 =?us-ascii?Q?jr+IJVJyM/6ulr6EAvmeXE5ZyoSsQlm/s5kyeEvGu93pxXhBxoQXqGzzg+S0?=
 =?us-ascii?Q?YyFV6HG9v3Ba6O756Nz9AsXjgbMq36AQzhziTgGzU2WeuEd2rgUjOCv4w4ap?=
 =?us-ascii?Q?aH/aF7KpgIotinVpJit21mD0y+X/ptxaqHyTB7H5PpSbWMSzdf6ptpn1O/DG?=
 =?us-ascii?Q?0eqa4Oky6SVDbn5ZIzyQGkYpaKEzEFf4d/UVKfOP4B+elsaBI7ljgk7JL9TY?=
 =?us-ascii?Q?aqY3zibVW7uHBhV9KfK1yhofzZgMpIuKlJTbh71/+BgGFbaxav6eusEcoodZ?=
 =?us-ascii?Q?7nHy1nlxWFX/MqU9VCLWyVmHJAKKA7ZpEwePmDitD6S/KSEP3AfQ69UNaxkz?=
 =?us-ascii?Q?VEyK7MiEEh2Ntf3uO5ElVYBrJ7ZMYDIAhkt9rZFAUqPkNHXllJ86FGMZy+ZV?=
 =?us-ascii?Q?f11HoR2WrOVEtN2ZT9uNFGPCB01FbrFZDisK635lLgp6X1LdOsJxMfXwpEvO?=
 =?us-ascii?Q?GMt1MHSON4YU09kksXDOP65ZUWjHO6+R5LLbLQHUg6wErXHh3TjaMcUHbn+Y?=
 =?us-ascii?Q?G9NXiphPnfety7eVLCs2U2KiuKHTcdbpf7DrO/PNhuR7tTCNqkW078So3+Ge?=
 =?us-ascii?Q?oeV1F9Z+KbzVYx6yPkBr182iaAeN4q67Ss5/ngiOI/0+zsUTltoYm4zyyYlR?=
 =?us-ascii?Q?qirF1+5Zq1mgska0oh+nEIqbjhXgqLvxsAGT0h59vCD9F1XyEB3iRQ2yep2K?=
 =?us-ascii?Q?IZCYVlr2orgbGuxCKNc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 11:49:55.5443 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b0abdc3-e1c6-45aa-c5fd-08de16e1477a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6974
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

Fix error injection parameter error.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 719991e99161..5377cde0c55d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1661,7 +1661,7 @@ static int amdgpu_uniras_error_inject(struct amdgpu_device *adev,
 	inject_req.address = info->address;
 	inject_req.error_type = info->head.type;
 	inject_req.instance_mask = info->instance_mask;
-	inject_req.value = info->value;
+	inject_req.method = info->value;
 
 	return amdgpu_ras_mgr_handle_ras_cmd(adev, RAS_CMD__INJECT_ERROR,
 			&inject_req, sizeof(inject_req), &rsp, sizeof(rsp));
-- 
2.34.1

