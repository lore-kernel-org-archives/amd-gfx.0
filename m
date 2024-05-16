Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C34CC25B78
	for <amd-gfx@archiver.kernel.org>; Thu, 16 May 2024 19:27:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6762B10EDBD;
	Thu, 16 May 2024 19:27:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3RPxsHhG";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD2BC10EDBB
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 May 2024 19:27:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CMQzoMkTEBcYIiTzDfrVYhA8PFW2lET8dIX8fja61xfB/I7GmYGzu3Zbs3+jt3CtwWMzo4Kao/7qw+QWsKOpBrZcWIO/jtgYl7I+4lSaKOb4UhAbbHN72kUqr/Jt+DmzaocGV0ymZtAXTYFeX+2up5WkmisqWQmbfCiNQJgdU+ePxnZKzDevmefop4vljI1S/4O2HW47s6if+mgakLSlxsN5aJBeZE411ANGoALVYh5c4T8kjez+25wquTjBcr9rJzAYhMpNYGb933Dp2FVLm9UgF6JCsn60u4CwmVZiwc9yDBpeR+P1x2lrpKCBuoaD/xkWk+psuxF2muKQVZT5lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5LTJrHuS2rtLxDZYMzaQIn917QO0YRNZwQUhYjfkIE4=;
 b=EvuT4hGuKnHPHPd/HYEoiEdCBUoJA7G8zJ7A2MMjIMdUb2g8PJNP5OYiZ5w1H3fQu1txhCXmRQxpaq0+RY9Vd/ehk7UpsCgsd1hQV/fY4Os2tUTBYnOK+KsrNHZv2r2YYADWwPOdv64fU9jPwM1BQGFO4RNZ0lAJTatYxPhqLUL124jk7EDpRwmxctpgkkTHgp56oDJntjDHW5BmwEhmORWP1NtxsZO8g18dYiWyyxKXy2u6hMPHbgEF3jXqbKkWB6U918KBd5bxvTA5qn+q9n6v1m+o2WwXdhqihwsp9kMtomZa3y+IUwP9ekoFZkqzJbqHhGtC3q43EPrsKOa2ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5LTJrHuS2rtLxDZYMzaQIn917QO0YRNZwQUhYjfkIE4=;
 b=3RPxsHhGXjOYILT2t1GBwfUPiTjdFtq8J2R2jFf6t+KwauvUdxcp5X8ipTafDHePC9V3b3425bo2TMs5+q+3kCtwY0M43+094AD1I3Okv8Oq6B/79rSoPd897bDlpIGI811lz8qFmPWBMHZ0QnX9pWVA7V8ZI9pP6abbqOHfixo=
Received: from BN9PR03CA0070.namprd03.prod.outlook.com (2603:10b6:408:fc::15)
 by MN0PR12MB5857.namprd12.prod.outlook.com (2603:10b6:208:378::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Thu, 16 May
 2024 19:27:09 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::12) by BN9PR03CA0070.outlook.office365.com
 (2603:10b6:408:fc::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Thu, 16 May 2024 19:27:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Thu, 16 May 2024 19:27:09 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 14:27:08 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 14:27:08 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 16 May 2024 14:27:07 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Dillon Varone <dillon.varone@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 20/24] drm/amd/display: Disable DCN401 idle optimizations
Date: Thu, 16 May 2024 15:26:43 -0400
Message-ID: <20240516192647.1522729-21-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240516192647.1522729-1-Roman.Li@amd.com>
References: <20240516192647.1522729-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|MN0PR12MB5857:EE_
X-MS-Office365-Filtering-Correlation-Id: 835959b9-01b2-4f0b-4d6b-08dc75de2df7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CKxgYOAEAear89H+kPiGEorvR/K+FkZ/VfjWFRu6Eu8FcIcIwWnl6BXTBpzf?=
 =?us-ascii?Q?u128szb7zcis5b0/k7U3WcvMRHUmuAxChOoIB/tnOfg41+YFjq1Fsz3MYkMa?=
 =?us-ascii?Q?+qCHpi706urZJdBa5+K6pBIV9LYBIfl+W9210Z17MBeVBIJjwQpGxofatxeb?=
 =?us-ascii?Q?CiGFsQTVQ7RzkcpzO2gsQegp6iKABsbzayZ7GciEY72cw84tDBZ8lUklwwr9?=
 =?us-ascii?Q?Yzm69i6hT5Hx3R8pAJq9PCaLOZPsxHCjzQlRe0sz2WVOZkKNhe0l69BdO4kV?=
 =?us-ascii?Q?NrkMQusrYJ+0FY7zKkAubTNbJpgbvZRqlfg3bBosf5uhpvy4QA5B4IvyDYc0?=
 =?us-ascii?Q?wu9F7I/d8e2+CqGeuOAU8P+o0awN8TkyvDctlETaRtFtEKzJKzaqo2cdLU7D?=
 =?us-ascii?Q?iCYDjMxtvciAiWtAGBJoG2xQyPvjAEItEP/32wiMAnpmeJt+2VIMuJSZxPx7?=
 =?us-ascii?Q?4osRwuNBb+MSwI/f8IgoTfhPiTsf8LC2W07XURMiOS9BOrBm0G7uR/wF1aXo?=
 =?us-ascii?Q?cpj0sk7K3PKAJvAXqvKwxNS8IztL1VSud/U/0tXyHA3Z3KNpJRaR2HkGLDvb?=
 =?us-ascii?Q?czA3Nl4TCbOKLPCJdRF8VrUfLEum0orE/vFNf/8VOPKuNGJMfwUZXHTnSf3U?=
 =?us-ascii?Q?Mug+WD/7UzwZLdVhbVt7e7EJVcN2Waq9vnw5Yl96A4dq3AbhSjjraNu4St9g?=
 =?us-ascii?Q?g9wbkIZkRlevNMZTOvywcAjW8IGmHqGNsyKRMVk0CnTIAiTWbYQMeJFolbBj?=
 =?us-ascii?Q?r1Svld7OFeSeluCSf7WTgEaJEwnqH+nyR0W7VWRO7HvVf2lm8g8VCYQ6C1q/?=
 =?us-ascii?Q?2WLiXeo/lmE14Y6bUqJgdiAvfD4Ty98AaJJ/dN4FC2TtG5sPObilQqOt4eJP?=
 =?us-ascii?Q?CfwdQOwOVpjaHLnBu2/77rP0mQUDNoK2REvHmQKtvcZPoJAf5SvDQycwcUsP?=
 =?us-ascii?Q?bzvmEdRNI270Uvn41Pz/sE0tUBiPo2fCGcybtCsvYvW5axhzdCrdN91KHuYH?=
 =?us-ascii?Q?Dw1wPG5iv0Em0+Gy/QdXXcHuO0XJ5+9tsTbGQY2CPSMd3oXCYsOziEN/+dVm?=
 =?us-ascii?Q?JQ5xspw3Ov2Pk26DpYa9lBAFqw/5gzifBszvIQrJ8QT2sJSY4mRpzK/FEpRB?=
 =?us-ascii?Q?cd7UUmVaJuyAomjamGkPOGBJTtrtDL8KHoVnIpNmTqWqSFZymxid88uJ5bGX?=
 =?us-ascii?Q?Cu23KDALKiVfDGLDvsisCYePA2HIxAXP5uPiKqythJNenAOCvR224F4trILI?=
 =?us-ascii?Q?O4skq4bgSox+LtsPwFHBsDH0pfmd3azUuqc1QRgvLMIz0nbKhwtptzL1KMBa?=
 =?us-ascii?Q?YrVVLMoGPtKF5QJYGITvEcrxKKa0ddZZcRrJ37MEdzcKSlXJezkIF0+zqIeV?=
 =?us-ascii?Q?nIG7N/MqFg9M4hyIyi8mUOhWpJz9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 19:27:09.3670 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 835959b9-01b2-4f0b-4d6b-08dc75de2df7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5857
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

From: Dillon Varone <dillon.varone@amd.com>

[WHY&HOW]
Disable to improve stability for now.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index fc43e7b5ec90..247bac177d1b 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -731,6 +731,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 		}
 	},
 	.force_cositing = CHROMA_COSITING_TOPLEFT + 1,
+	.disable_idle_power_optimizations = true,
 };
 
 static struct dce_aux *dcn401_aux_engine_create(
-- 
2.34.1

