Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F94C71144
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Jun 2025 18:41:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F63710E35A;
	Wed, 11 Jun 2025 18:41:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MJ4rqCo7";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96E1810E357
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Jun 2025 18:41:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MIVPNO3XW6t1wBjze2wb4cccOUH7WaEiaYrtLBRJ5Lvjd4qTMbncYmK0of37joFzYO+5Om1R2Uf1x7X3DLkvaITZ+OvlgKTZgjsXvViA6prTKQxG/xxz24QTYSlUruavg3DZGS4iDJ3mLRd2PEsfCD8jj4ok5zue+oHa9b3TlgE73oXLDunrqloxml01BmngjWjlJq0w3BiQqpdbWL4a6gLMtj0Cadp0aeEpHI6tiPTo7CMnH1FvV/Cav+8HapvRPCGJuj687VufueUAjDRia6aSS3EWNzzawBBCwpmA8qlWg8ksA8LhaFDjhwLg1lh1wC1ABMxCKGW0DfBLKCRa5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4T6tcVKUuOD+TGwToZKf1zgyUNpnrPQFtMvNycmTOPM=;
 b=gLUBfRIH9lGAWxSsUtkGDhM+4DynzTkEHS2IA19sL5J622u6j4G7StngSkQXlNgVKQmcnAmXFZ8vnrf+rdZTacSe05Rd74hcYtURWGk35SuVIf2q3uJAxy4wqpAkBtCX08zryCIZqT89SMzLOR+jL2O3Zj2J0QhTYUyOt9/42GkhgT+oePo8UvpExx1bBv+DFSHoOQKdJ1tW+TVzqL4ADiBytI/GGaighwW3tG8qhvjOo+4CC5TEzxGHLKeK8ErbbKt5UjvPWxZ9CU7sY09MFvMgNEEwpg5BfR/36iwqX9cEdtpiODkho3bW+0f+KJnXJ5OJE6qvZhwwq7cKkFWUjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4T6tcVKUuOD+TGwToZKf1zgyUNpnrPQFtMvNycmTOPM=;
 b=MJ4rqCo71cpW0ZUoZczWAVmVDE0HC5sTgZAlV+BYo6ELGBSb9MCrHtZM6jwLRigxvw+CwPe8vn+eY0P46+tTgDQ63kGe/vt/k6iwGII5Og0cz5ymUxgm6uigSQa9x2ePkqqLWqwV/wt0xRzY23jORoyyWn6p8Vt3wCQ8ODTZrmU=
Received: from BN9PR03CA0495.namprd03.prod.outlook.com (2603:10b6:408:130::20)
 by MN2PR12MB4391.namprd12.prod.outlook.com (2603:10b6:208:269::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.36; Wed, 11 Jun
 2025 18:41:19 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:408:130:cafe::c9) by BN9PR03CA0495.outlook.office365.com
 (2603:10b6:408:130::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.19 via Frontend Transport; Wed,
 11 Jun 2025 18:41:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Wed, 11 Jun 2025 18:41:18 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Jun
 2025 13:41:17 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Jun
 2025 13:41:17 -0500
Received: from aaurabin-z5-cachy.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 11 Jun 2025 13:41:17 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Charlene Liu <charlene.liu@amd.com>, Dmytro Laktyushkin
 <dmytro.laktyushkin@amd.com>
Subject: [PATCH 08/10] drm/amd/display: add APG struct to stream_enc for
 future use
Date: Wed, 11 Jun 2025 14:39:58 -0400
Message-ID: <20250611184111.517494-9-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611184111.517494-1-aurabindo.pillai@amd.com>
References: <20250611184111.517494-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|MN2PR12MB4391:EE_
X-MS-Office365-Filtering-Correlation-Id: e194ea48-e979-4a0c-34b4-08dda9178e16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HndiM4w2nltrauursrbPNtg7zdsH8axraDRLhowywI4ZBcbFCK4Pkp1P4CRj?=
 =?us-ascii?Q?KsDWFQfEMYRkF/NPqRz1Rgaq2Dcq5k0jY9PiJzF1EUWmCCgMkn7uoIjIPN5O?=
 =?us-ascii?Q?bvb6eHWUiix/6lyCoCbCV7viWwF0HYrE0vSwBofbzC0QFV6xwTySAm4fk20F?=
 =?us-ascii?Q?gnmZH8sYswBsVhO2QLeZ448NSCA+DZeXGVic8X5D8JXGvSt29ilZxY+w0xV/?=
 =?us-ascii?Q?Jps4iwxDf/OV1TXgtUw8TSTxnrlNWszKLXJ5A9Td1J7vvHXv5ugA9ejS5UxM?=
 =?us-ascii?Q?rxYJjv2HcZgILXsNZsETamLbHCEaojEQ6pczUSOt87Hxo8K4ZTJKnwG6yR/R?=
 =?us-ascii?Q?tZABnasj/6cneZBWqWmhtOSxZ9KnYuSZKMvZdFSW5YjhQBaPyyOyw58F39Bb?=
 =?us-ascii?Q?G7Ssps37yDfSVida4UN5UAbzN2y1KqTIzg71BZyisaZKdmbJ7PlkUFdi0RYi?=
 =?us-ascii?Q?GZ7hVzvMVgbiq4gcyAe2Vd5Dyzl28lsWBmDz32SvG9Nba/GdFcNLAwAlUzb6?=
 =?us-ascii?Q?a+EIS1zX5w5T71LmQIMdvGtqoeF8bZznE8w8YHjM5K4VyomcRVcZ5jZTxesQ?=
 =?us-ascii?Q?V07FArEBcswaQ6n8PYEl2+DK5GiCnxIRWrZ+T+EZRfXozZob4GegsK6O6XZd?=
 =?us-ascii?Q?7uLso2/7VFpQy5Jr41zQf7g2DSyU7Om8/SIRfKsTbAiqhMlsljAtOaDPQH8G?=
 =?us-ascii?Q?zd0K/9WIgNVXXOUnK9LRenR29raOmRBQXI9UZ6JyFKfTR8aupFzI8itiDjku?=
 =?us-ascii?Q?tpKjdsQDoC4jOfbrZ/PLq2QNJdeQul5lzhTsBK2GKp+SMLVpls+Du89zlrs8?=
 =?us-ascii?Q?4z/K5VJnt8MtMw5QXFMf+LMuv7xc03dAnnwmLsfhJnFllg0JKBpfUjmqUWj7?=
 =?us-ascii?Q?UC8yfl28sAjQ279tma42aJ72s6jTSRFEc60H+peU3iXXfcjSQl90owA6NNq0?=
 =?us-ascii?Q?kmFKpGGPf4yUsMHHMHLibr16TPrQj+lRabvuvuJwOIqXWaATEMFCGP3QBkjq?=
 =?us-ascii?Q?Hf3KBxnP1BIQ0CK7Xi2AfV6IV1aNGqvjcgqSinmWuLZTCsCL76yf6baJ418M?=
 =?us-ascii?Q?B2viebXP6MDDxrrze3tT78XbsDLvfb17c6xWANEEnwUD+tD6wpE+XwmfGRlb?=
 =?us-ascii?Q?uxJMslVRiEfEzDk/f7PojXqb9szoGOLP3vTy8T38jbPJ6S/cQRK33Qa8Cah9?=
 =?us-ascii?Q?WQlvmj8z2jC/qgVS1objVTIp3SGf2w3cSyum3zkxjDgm98o0dtD+e0+3a4/v?=
 =?us-ascii?Q?jnB9xwfrDSY9cdK6ac6yDLFEgUN7bMpsk16fX0o98n6ohjQrlWUm0WhqRiiP?=
 =?us-ascii?Q?0SwulPlPQ0Gl3rcgzZpuhWvAJa/3mPzwyoUOh9HG2bOw62dke/lcpOhhQUkU?=
 =?us-ascii?Q?h7oaAqprk29mLev8pOzKbGKAjhNkX2jnjnFtWNOFx8Y+IK9MbeA2rhhB5VsL?=
 =?us-ascii?Q?aJkC+jvs8opWWfwxo0g+4UNiGbetAyCta026ZUqWpeGEclXR0EbVLr6ntJVw?=
 =?us-ascii?Q?soHBHCVRNnIBN5KiRznkk/pEAfqbET/dD2/B?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 18:41:18.9187 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e194ea48-e979-4a0c-34b4-08dda9178e16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4391
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

From: Charlene Liu <charlene.liu@amd.com>

some new asics will have an APG instance taking over certain functions.

Reviewed-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Signed-off-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
index fe7f3137f228..27f950ae45ee 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
@@ -117,6 +117,7 @@ struct stream_encoder {
 	uint32_t stream_enc_inst;
 	struct vpg *vpg;
 	struct afmt *afmt;
+	struct apg *apg;
 };
 
 struct enc_state {
-- 
2.49.0

