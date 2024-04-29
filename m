Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 279CFC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 07:29:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 781A710E88F;
	Mon, 29 Apr 2024 07:29:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cfwlXHRR";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F55F10EC15
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 07:29:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aoxlaTtmmqWFkmAKj+xgjCC4EPxTTQxjwi9HTaDsnPFL6GSfPmM+91XjuqQrg10Yq/EinIvJ/EWMPSOapqlyc/B40/ggCZZ/bHj4QRbxbZEIvgMSLSQuj0gkIAa1PTOgacBTRgtU+mUV03gjmykOpQ4kK9UltLGJRYLYJyG6fS3shRclYSVkOiO2oS3WdK9Bftzigewk70B9rPKpjt/cqUXc6yF0jUwONdn5lJRB6jFiCGCHH2+KnvW0lzx2+4xwBUBKHMcbwHfQDLZc1IYUJFPtaQJh9dbU4wEm3uR6YCY1/N+JMI7oCOzJ9y2ixgq16F1XyNIFbhEeAupY7o4jyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cLde2EXaZ8ppRpf+dQfoFawgxdBj77Phit4GGvnvCKA=;
 b=mf3sYdJq4k3J5m2VE8TjdjBvMhH9ukVKXamU66WiCOq+37vwUUEciGsvWA9CUO9ad71bBPuwwUzR5JuERnbSp4EvbTv+jnYk9xZxQm56PNNW7k+RaRzOm3RygwXlsRaes38Z4pRXoCQGxmnNQquGnOJ3QoOw7yC2i48kYZKIqEb4UfYuYomuwKGnYaYF2rsEvZUrs/IC0fE8mVmu5Yfefxs3IULO9POop9uxM07UInh7sF1DW6/6pIa8WnXP7Z+3lWPHSYhh2RELbxDjtJMAFraHsFWUSTwMBnCmj+pwoawJnx35566M1n/F/Z16JHxibNH7LFn0QwuLi+2GFHbq/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cLde2EXaZ8ppRpf+dQfoFawgxdBj77Phit4GGvnvCKA=;
 b=cfwlXHRRHyRFuj5K7/eUfKtESP0jmGDpCVaB5sC+LwoYaGPyfhFFYd2Y/1o2tAH5HplLkqrrmJ3398RH52kIoQHFr1DeqGYaApS5qSbaF3s7JPU0knKND1wwpI8vR0D8H0dQzd8iTWG1kp4EfB9yCluMkHDdNeGts0opiZqv12c=
Received: from DM6PR03CA0035.namprd03.prod.outlook.com (2603:10b6:5:40::48) by
 CY5PR12MB6551.namprd12.prod.outlook.com (2603:10b6:930:41::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.34; Mon, 29 Apr 2024 07:29:30 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:5:40:cafe::3) by DM6PR03CA0035.outlook.office365.com
 (2603:10b6:5:40::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35 via Frontend
 Transport; Mon, 29 Apr 2024 07:29:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 07:29:30 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 02:29:30 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 29 Apr 2024 02:29:23 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH V2] drm/amd/pm: fix warning using uninitialized value of
 max_vid_step
Date: Mon, 29 Apr 2024 15:29:22 +0800
Message-ID: <20240429072922.2069718-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|CY5PR12MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: d6325d7c-4b71-467c-2fe8-08dc681e1bf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400014|36860700004|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AUOP4NeWD/q9uV7+ozG2PKmKwINRAMmL9RuuBshTgwg2UUDalwMicS46RYe2?=
 =?us-ascii?Q?hB5OpSJeKEYku1XVUfNnYUXC88dRB61liw4itP/Kq5rLaCsmtee9HNpomqgD?=
 =?us-ascii?Q?idbgiEuzdmnlCtqQRQb4qbe1AY+CdHE4WIFXL87BAhvjkbBzYA9ntOxCHqDh?=
 =?us-ascii?Q?FndZ1mq2YTQVgBVSwnZzwe3k8F8QYpZyAW/gQU5dm2aQOXoNEvmNkHfPdbk/?=
 =?us-ascii?Q?+O6z+BrymMt+zFDeQy3LGfxaqAKJOLyUorW4Nc7yytIgI2qv55+ooe/7sing?=
 =?us-ascii?Q?mdcXpTrOFO2PygYdq/BFAgQuZo+AIVPA7sQzEuxJ6NqLwDRJunuzLfJ+kMsV?=
 =?us-ascii?Q?Hw97IgsYR2/ZiDLjYWAJx5Fb3lZn6SLN8Uc/h3N7PBwGwJuFej0ygpJOrk8I?=
 =?us-ascii?Q?FRSI4FbANfYHOpZkGcfUiZ74bKbtdTS/n9zlFL83E69wQiNlVyTnFVZ+eAZf?=
 =?us-ascii?Q?IwJbVNiymrUeoIttKZfdz0zjXZwEHTj7kNfOObPazSz4n43Z5z4Yi3ThS83/?=
 =?us-ascii?Q?ATUtGwmS8pNEA0oAncT6F8c4VhLX4C/tLe/KS4OD59/dnrBHxEOOrZCr/Fvk?=
 =?us-ascii?Q?i9GwlohNe9Gl1i26plN+oA3vwzfSErAan94+y3YZgGoe5KMepuhsAH2hqxsK?=
 =?us-ascii?Q?AQx7a3r4uCIKmOM2zb1/y9rcIJ2vKbMbxF4zSsl4VE1i0et36RWSR/2PTM0a?=
 =?us-ascii?Q?dQRhMJNQcXAP4nJbgXJx1PCmRG1zi0okP9JT3ZfJQGzrxungecvOBkKsmKqO?=
 =?us-ascii?Q?9hikrYDFdI8+5uM+f/mRX4DaNmrHKMjlFy6D7dM1/WHjciV7T6uzWWk8hD5G?=
 =?us-ascii?Q?6W+ELD4y8yrjaSXmb4Kc7yxu/E1E/jALqC95zFHGDgVfafHgF9ULOQXAFFMi?=
 =?us-ascii?Q?FbjhsVxGmk7FSqQup+h+/zhUoJOFBRP3SSY1QGO6lStGnXpOdWHdfe7EesUj?=
 =?us-ascii?Q?EpjYTsfCWSD5CbPWue/uSdcggX2mroNbO3lsx/4QjlhYzKaLN1G/TtuFSRCQ?=
 =?us-ascii?Q?9dpxKzqiShl0676JAisL17nXTgruWpBdVZclkTDSuVcxHDTByuIhQOPJf29y?=
 =?us-ascii?Q?GxNyZ2wqpMeDLLFO9EqwMzvtSbXcY4+9UWl8J+zf5kwvGYoHBgrbCuvNVyhb?=
 =?us-ascii?Q?A6hyntHbYYQiz9S5YqLTQ/Joolpuep0eOh15BU1jEXZANE3P14LRlnhqOT9b?=
 =?us-ascii?Q?++X87FUc8yzylA5bhejTr+SsDaVijzlho9XKQNxHjTLjODe9/2gk136n2BbO?=
 =?us-ascii?Q?BtG46GAluRjy5EtBFN+4fDzyDvxahi+BT8BWgChQhc1lILX1LchfoNXc+Wiq?=
 =?us-ascii?Q?EAPqM3krQDiFhDtKSiQmSGxSo1qhEy1UazeMWbM7y89CMZXILLtVbMjYz9xl?=
 =?us-ascii?Q?sNUOoNt+zEwqnxqO50Cr5eSsislE?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 07:29:30.5994 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6325d7c-4b71-467c-2fe8-08dc681e1bf2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6551
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

Check the return of pp_atomfwctrl_get_Voltage_table_v4
as it may fail to initialize max_vid_step
V2: change the check condition (Tim Huang)

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index b602059436a8..d004cdbe97b4 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -2573,8 +2573,11 @@ static int vega10_init_smc_table(struct pp_hwmgr *hwmgr)
 		}
 	}
 
-	pp_atomfwctrl_get_voltage_table_v4(hwmgr, VOLTAGE_TYPE_VDDC,
+	result = pp_atomfwctrl_get_voltage_table_v4(hwmgr, VOLTAGE_TYPE_VDDC,
 			VOLTAGE_OBJ_SVID2,  &voltage_table);
+	PP_ASSERT_WITH_CODE(!result,
+			"Failed to get voltage table!",
+			return result);
 	pp_table->MaxVidStep = voltage_table.max_vid_step;
 
 	pp_table->GfxDpmVoltageMode =
-- 
2.25.1

