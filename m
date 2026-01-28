Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD01BD35660
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 02:00:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EFD810E602;
	Wed, 28 Jan 2026 02:00:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wzeboDUd";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010043.outbound.protection.outlook.com [52.101.61.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55AC110E5FF
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 02:00:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZSdSpYFSFXodTCFlJyj7/c8lPOpjdSdOVHCV5qK7uz2U/PEsAkNDan5xnycRisb0WUHek7AYZ8yhV9MxD1dbBxLvKCqVvRMR4ovG5jVR023OaHL7+a/sp10ZSKImqXQRSZRx/SS9mbw4jpyHPQwkM7wYwER4QYeQN11rnsicgPev0KcnCAIda/WXBFmWZXKGeZusEtJiI2Ku/EC6pdOkBNOsv9DGI4oNasiIdixXuWTJBmBbq7xp+DuU7YDEDaGOt73s41N8CM4AlR7KI8XnB+tuuxhSB3VpmEot7EG2N0CbR3xE2bI+z2kDX/FwQF6Nk18RAYO+rmTlqptQaVZJ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFG2s/8+2ItdF2j3THGqlQwFu2hzspKdACTHIHfn/8U=;
 b=uc69xMYsqElMmDM677kDGB26XQCcW4jpzbXYVXIw7MZJqc/IDM/+3z5q6Ki3H8cbETm6o6OKCyhuzCUCUtSf4HHIlrtJEdNAZcpxjdsD4AyirCU92oNvngGIrB9cOEvkVlYENjhA8gwi6AK8zRguUNLJllc3h9MPk9XYVYOOFW1nU37MPnhMYQAKJgUBHELFub35qUGIz9aKdwZ0orfmbmS4XfBtlt1omoNeh8+SLtZ5ZMmHfik14xRjNzSQl4B5rGD4VokMpZhzuRo0ykEamrZStWksgCQmGEAQNKK6sJh3rzNMyseFaiTjkvvSSGRz0SeZ/NAJCpBOh+8+KIcOgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFG2s/8+2ItdF2j3THGqlQwFu2hzspKdACTHIHfn/8U=;
 b=wzeboDUd/Q3x5NE1+Iply95fs9wqi6/qGe8qXn/820WPfqbUHGMyB2mqRDCbV3fzO0OvKpslk4Fq0zHLRxuVJ0hFfOVFwTV8ORgbuEWbq80WiwhUA+ngTWsfGOhOUZmDYJRDqSCBHk3NqI0u8GaCMdir3Jyv1Xtk4IG5m3qrU8I=
Received: from BYAPR02CA0051.namprd02.prod.outlook.com (2603:10b6:a03:54::28)
 by BL4PR12MB9479.namprd12.prod.outlook.com (2603:10b6:208:58e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Wed, 28 Jan
 2026 02:00:35 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:a03:54:cafe::75) by BYAPR02CA0051.outlook.office365.com
 (2603:10b6:a03:54::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Wed,
 28 Jan 2026 02:00:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 02:00:35 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 27 Jan
 2026 20:00:28 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 27 Jan 2026 20:00:24 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Bhuvanachandra Pinninti <bpinnint@amd.com>, Aric Cyr
 <aric.cyr@amd.com>
Subject: [PATCH 18/21] drm/amd/display: DIO memory leak fix.
Date: Wed, 28 Jan 2026 09:51:43 +0800
Message-ID: <20260128015538.568712-19-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260128015538.568712-1-Wayne.Lin@amd.com>
References: <20260128015538.568712-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|BL4PR12MB9479:EE_
X-MS-Office365-Filtering-Correlation-Id: 60e303e1-dae8-46f3-2890-08de5e1106d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qeVwbQpJPmg7+ips4f6AcxVLDJqk0OB5I/ua/ehyiHMm/FZoTjmlWsy2kAOz?=
 =?us-ascii?Q?dgGaIa05veNp2h4d75skJicqaWNw9l/niiYmYHozjIMuloySI/icaUB14Chz?=
 =?us-ascii?Q?M1xowOyPTZBalK50qjvIJH25i18PabitNhI5uO0x/yF/7M8HNfJsMe7M+bIw?=
 =?us-ascii?Q?YjUD1SfCDHtiFXzJPxjASiCAWpnhTgSMxii7pviTIhIpJXozP5fHXqobfB1Z?=
 =?us-ascii?Q?BU16yVHXKOX4eUKNKcizYBZ8BKkBlZo8qOSA7yU1buNjeLpJ4b636YrttYB/?=
 =?us-ascii?Q?Szxsmf0kV1hyaquesagtL2cgqGhteTV3ZKCxGJ7KTplMjPntZfUrefTRe/7d?=
 =?us-ascii?Q?ZNApKx4NFfU7rRbSQ5btuNkz4PcposSDcxEQQcHZQV6CHraG2ww4L9zYx7V9?=
 =?us-ascii?Q?diVr9Q57RU8/R8bBF17STp9tuW2EtLcg7Vvca2uSINi0nr68Z6cFrGqjJZ2N?=
 =?us-ascii?Q?8v/OAl3XdAn9xgqvRqi+mta6BpKzIWGYgK6e0yCyloMzJecTpxF3eFIkf/dK?=
 =?us-ascii?Q?UWfDh9cPN/ZeD5koWuEQtsJC+tHJ2WXkUVFklbJnwlaX6P4qzxMd85ulS4C5?=
 =?us-ascii?Q?P/W7odoqho7Vs8tNeOCrxsX0+Mre/prUKPWpVgYRjlUYXOLIPB7GkWA7gyJ7?=
 =?us-ascii?Q?71M8Lp+yxytPKcFREL5DLIrokkXGE1UYrCzyeYERDmOaOEE5DQ7S+jVi2CyI?=
 =?us-ascii?Q?fdqrTOEvU6QHqe70FIBQSW/S3RimsiMFNsgpBhPwRGuV0It47BzemX8G/P1z?=
 =?us-ascii?Q?zHQd7mzS3jdE1q0Hw70JwW8VUgxn9V11A1x10kbByQg1BbY0eDpD8bTX3Zf0?=
 =?us-ascii?Q?tkJi/fNCkN+Xv+8VGFesWbC8l2rS7BuTxwxrgQze1ikno7No5zRAcXlNXrxS?=
 =?us-ascii?Q?JOZT3YaSf4H0s+UYF4U//LRGRdkV6ylgS8V+x01qOxrAO5i39E3pzYkqtbBQ?=
 =?us-ascii?Q?Xr1xU5Kd0FDZmp9/wmMJVHjYBR5qVfIbSKnvIihGdC/KK6YY+sUi6q74jIak?=
 =?us-ascii?Q?0A89W5nlQMJTJuwKZXCrN4e6yV2HclYr+GukqP0uJokFy28HAvdjJQIPQhhs?=
 =?us-ascii?Q?+K03KdKaA4YGhydTnJYU2s6axaqX4pCxf6VHJov6QbKw/iCKB5kjcV/QcQIR?=
 =?us-ascii?Q?yz/oiG3XdQSSikfIzK+KrV0EpU3EKRX+7t/R01SnEvmhk7GDMxGAVKW5DRb5?=
 =?us-ascii?Q?IRDE45kQWT243PkOobVIbm4zeqT5MapxYA2xB/ROd0Ut96BX8Iszjy86EbPp?=
 =?us-ascii?Q?TnbkQZqDzTQTiCRImsP8BWoQkIh06YRIErNpzONnjwP9Hlbgo4vJSV32gfIB?=
 =?us-ascii?Q?BXezlGy0+Hs4dJdrdpIAlOJdlLfIR4rKfi9/Q4m371GyprB8eHgZo57EHG6e?=
 =?us-ascii?Q?WMZ+T0kZhkyLqxwWf/5iWJqieTPP2UTnOg+g/HI31HiGfEd1fkJCi0IN5aVJ?=
 =?us-ascii?Q?YCtdjzQ90kiDa5p2KW/YMZIza3w/hhbpjgfRAACzY5VaiFEFT2ntaDntVPWH?=
 =?us-ascii?Q?GJMrpwMcgJPLs42h9Ya+bZJy3deapzAbKd7aEUFpVe42SoRuZWDk4QOvvpG7?=
 =?us-ascii?Q?t5sEyalWY3jjN7zFCDss3/hdCbUjId/mUprcHnBE5tdSy1ApRey5+xbSMb6P?=
 =?us-ascii?Q?OrvU7gh5g7AqRCoI0LD3hXizkmnGzqbxkl4ehSXPvD8gA9BfiywtWeHZTR6p?=
 =?us-ascii?Q?y5Eqhw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 02:00:35.4188 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60e303e1-dae8-46f3-2890-08de5e1106d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9479
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

From: Bhuvanachandra Pinninti <bpinnint@amd.com>

[why]
Allocated memory for dcn10_dio but not freed in dcn401_resource.

[how]
Add kfree for it in dcn401_resource.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Bhuvanachandra Pinninti <bpinnint@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index df3acf589582..4875faffe873 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -1532,6 +1532,11 @@ static void dcn401_resource_destruct(struct dcn401_resource_pool *pool)
 	if (pool->base.dccg != NULL)
 		dcn_dccg_destroy(&pool->base.dccg);
 
+	if (pool->base.dio != NULL) {
+		kfree(TO_DCN10_DIO(pool->base.dio));
+		pool->base.dio = NULL;
+	}
+
 	if (pool->base.oem_device != NULL) {
 		struct dc *dc = pool->base.oem_device->ctx->dc;
 
-- 
2.43.0

