Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 378EBF94CC2
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 03:57:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCA3E10E210;
	Wed, 22 Apr 2026 03:57:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Slsa8Jk7";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010038.outbound.protection.outlook.com [52.101.46.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E52010E210
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 03:57:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J6CA/Wc3ZPpdmCoXPTY7AKFXzDppgDlnSAYQGTupxM7pG8i45E1ALnHhLg2biyfU7dtDfsYzxWIGg874ys7vIDVUf3TjPhYkxRHprlbEuuxyHXfWiMQ5s2S7aWhpC38kmKaCTn22Aa5K6UipbOWauwJhw6EwB/WSNNEGGSZdXz2xBQjHIw5EdLSjSALyOrgJwik4HxEmb9Ny5Uo/yHHKnI37conU0QXOZ3lOm89ypxHfMTctiwJUhmqbviJ9NgCCgJ4i5pA7QcRyG/wYzIg1lDsVhERn7Y1YwZkF33fdH44JxrQfSfPvwJOPrjwvl7k5Og1t8J4GbZtnEyHxYgF2iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ojgTS20z9eF4zecOppjHMwkob2kx9PMYja1KrK82IWY=;
 b=S0xR7sGwK2UhYzLKa3iXj7eqpYj0NOv5Pqad4wUbNq/MiEHFQJP4Wtwr29S9dsVV356j1j335hNiX6HhYn3kEZiHaSM76X3EbHKARnB6jv7BYf/EBmztlovafHzRY5r9QR+UE9gbuJORodBxQf9TIgVxA51BFI34xMO/+lnet48B3GRJV4eWzGCceyBA91N51OtHQKzMmLgANWK7KhgAhKXoYj+Gj9OFJwAHjdvMP7yqYnFCO0ryhX37pK9faijgC/4nmYZjUAYkVKi4P2tUTpcCFUL5iI1MK2Tkxmp2nRzOSxFVca5E+g1bB/slxzmOrH72ttl+5CtTDuja7Bo2+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ojgTS20z9eF4zecOppjHMwkob2kx9PMYja1KrK82IWY=;
 b=Slsa8Jk7zjKfhT5/CnO3/I+5MwhfJeV2azoMcZZkKGxEhoyzkwE9JQc+NNg4x4550D93HLODp+1CBpYt1/Wv9RJ7uGV962Ew9zUPRB3YLu6a7JZ2FIAA/97dTgwlesezjmIoptivnHWUGtH1U1RPnBQlTSwYiMuVDSCFxr35aco=
Received: from PH8P222CA0030.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:2d7::11)
 by DS7PR12MB5861.namprd12.prod.outlook.com (2603:10b6:8:78::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Wed, 22 Apr
 2026 03:57:08 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:510:2d7:cafe::f0) by PH8P222CA0030.outlook.office365.com
 (2603:10b6:510:2d7::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Wed,
 22 Apr 2026 03:57:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 03:57:07 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 21 Apr
 2026 22:57:02 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 21 Apr
 2026 22:57:02 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 21 Apr 2026 22:56:59 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>
Subject: [PATCH 10/14] drm/amd/display: Enable RCG on DCN42
Date: Wed, 22 Apr 2026 11:52:48 +0800
Message-ID: <20260422035611.1870316-11-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260422035611.1870316-1-chiahsuan.chung@amd.com>
References: <20260422035611.1870316-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|DS7PR12MB5861:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b22cd6f-9f54-432b-ded8-08dea02338ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: pQSlmuzFmqJQ2gb+/LeH49bf5IkJ92R6nWjZuO4uUSDBYGTOKoHpaVLmxF4PJg0z0DyKeR7U45s1D0ZOSLA7NYsdxHZBU69WcqYsBeHDPVsHCZFia5cO0m0X6Gr0uhBjuENxwMGsseLePiWCOHLoFhKGdTWzEAem9ITb/D8x+U58TTuahB4cgVrhBkd182kze3KH0UDYskiudQqknGa3+BXqlVi8YFhdGf5bn4mzd1dE7L1MSI9iecY/+GMD5Fr8MD0LbYpMFDPwmAztpPUf0uu5Z/SoAlj0RqP8mhzaWB/L+RY31eA03WITGG4DnaJn8E2qP6ctxtIXGoZSjYrTg5EBq8y2FZP6kd+ylk/IfVYDUajJxn4ZaLvL31MNNXn9DhJ/pFHKCPg6TzopN3m3yciHqMzGlTAYs9M/X/CTmDJBmc6Td7YYu8U9kuClmep1vpngdy+NjtGrjmF2w2fFUdll4Oq3nB3tQlY24EqDffDCMqvdNASoRJXYBPN3ijeAi654T1FsfjVTktpJhei60IxKufN1yBx1guNk1+K9w6yn6klZUWHSbYcPnXi0m7SwTU6VnDYeRMSY0eU8jGztmlVyoP3TiukO9GYzirNBr1ZEj2qfmAvA5ZnaDsNQLecwrRDu/GMqIdz1P5j4MTGBoG3RlwXJW8pjrTN/n/i5xBl+BAohAq0MnGJLb59gW+kzH0lO2jfLtcdl9YYU9PoBuuQqAM399GM7RcgMH2oFJjrJd0lsPFtnOfC6dDnydUuH3WmSJxSh5d0lEdOgKWWOmA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9dY5BeGBdUyZM0YXQm/kWKQB3+xaQL8TPsTtD+SIxE5/BtKlP88CIEsccH5RTy9xMzt8wcJ22Dp5QIn8pg5y2teumILEXti7ZDovQUN03U/rcBDalePvIPsw5E+bczMtjcdASj0AqsFq10g2frblGXx7+8ivh8FjlIGhkTZzGVz+Sr5GoAMNqde0zNlA+PEPa617JrulTDXl+6AyBCMbv8QAroB80o8GcQyFWS7a+V21sKsv064aaR0ggVkESxaloMA1XByLLu/yXjJ24tD9iCDkvu+s/5N84LUqapU1AcoTiFWszhEW0BF/wEGJcyRbiSHrHMhPN7ZfKxcpfmUaSq7998S6HJwpZY2CponOEhvY+aKB+UdqBOVzFJcFZ5Z6zU/dKI9A2QOHuuBppn8Ya5z+CLF+POlqRdAJJuWgrjfNipgWbTAjpdsYJERB43aF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 03:57:07.2907 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b22cd6f-9f54-432b-ded8-08dea02338ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5861
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

From: Ivan Lipski <ivan.lipski@amd.com>

[Why&How]
Align DCN42 IPS state to DCN35, DCN351 and DCN36

Reviewed-by: Roman Li <roman.li@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3fa4dbda4517..37c2d18bffd4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1864,10 +1864,8 @@ static enum dmub_ips_disable_type dm_get_default_ips_mode(
 	case IP_VERSION(3, 5, 0):
 	case IP_VERSION(3, 6, 0):
 	case IP_VERSION(3, 5, 1):
-		ret =  DMUB_IPS_RCG_IN_ACTIVE_IPS2_IN_OFF;
-		break;
 	case IP_VERSION(4, 2, 0):
-		ret =  DMUB_IPS_DISABLE_ALL;
+		ret =  DMUB_IPS_RCG_IN_ACTIVE_IPS2_IN_OFF;
 		break;
 	default:
 		/* ASICs older than DCN35 do not have IPSs */
-- 
2.43.0

