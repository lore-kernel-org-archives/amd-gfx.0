Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29709C2BD09
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jun 2024 21:15:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5BC710EB67;
	Thu, 27 Jun 2024 21:15:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ngpb1XVL";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C03010EB6B
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jun 2024 21:15:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LjxHkrq0QYSD2/+V44/leT9TAP+KnZfTN2faX445i1fKEjEshMJbIdmUSsGn/uQpD7Uj+tygkQkf+ZeNGFnIJ2GagYy3VeoA0RarnHlLAozffETipCarUZfZJ2gj5AIMJ4+q6Fl8dmsUXyzUMMauzvxohezAtmIekXf4PfD8XcSqHzm6zS5ISzxNVxamx0dKPxEeug6KiefO8uImsq/bD1kDIgIaQstMB/qs+VsjJdbvCeDbMGcOGUksIWv2Gb2x80nOn93vHzC4q6waIMJAw2j4uf4qRfopXxDyC3Hir8hOVCRA+xnyuJXH84auhweabeR4hJgyguW0hXg8yQI6Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KnHh446bOWbS/lYDOryp+9NP008wPY0BzxEPzeeCH+4=;
 b=l6ffCblrUZx0y3wgCPGf9LYZLGskwIho3Oik6SxEI9N0wiC96IedcCzbllDe8ai98dcwkzbBQHyG30puDo7tOCjxEkvQjPlKHPJ/rvzbHfBaaCL8dHTu+SfetnP2dOcW8CuaD+irA9KOpHyNf+Lpk6jMFMDsdue672a/ZpVtwv7R175gdjKVpLNI97AcjsSDjXem4oHlpio0TrOuKV8fWwkCIvVxSd9F4RX5FWfAoNVFK0clO/U51ho1jnC4x9jiZmcSjOp7DUBhB5NruajX6a06fQfYZnYmY4FLIV2LI/Q6xZAmWLu43FcUsrfkUoIAl17CPuIXIatEM9AHiI9U5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KnHh446bOWbS/lYDOryp+9NP008wPY0BzxEPzeeCH+4=;
 b=ngpb1XVLADKbbSjLsJPCkJdPK//UhPd2rE3u46z01FGGk59IsEpm+H2pB5djDf5brGJf/OZAzvRaon0q74jgwAYOnELovej1zJajblVak+OznlTKEx0hcxS1ZFPabRDBZrNwOOIhHTDugcVIqtlwbtJ+ZrVqf99fwkvzZpX4El8=
Received: from PH7PR17CA0055.namprd17.prod.outlook.com (2603:10b6:510:325::16)
 by SN7PR12MB7274.namprd12.prod.outlook.com (2603:10b6:806:2ad::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 21:15:19 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:510:325:cafe::fd) by PH7PR17CA0055.outlook.office365.com
 (2603:10b6:510:325::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.24 via Frontend
 Transport; Thu, 27 Jun 2024 21:15:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 21:15:18 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 16:15:17 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 16:15:17 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 27 Jun 2024 16:15:11 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Aric Cyr <aric.cyr@amd.com>, Rodrigo Siqueira
 <rodrigo.siqueira@amd.com>
Subject: [PATCH 26/26] drm/amd/display: 3.2.291
Date: Thu, 27 Jun 2024 17:13:29 -0400
Message-ID: <20240627211329.26386-27-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240627211329.26386-1-Jerry.Zuo@amd.com>
References: <20240627211329.26386-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|SN7PR12MB7274:EE_
X-MS-Office365-Filtering-Correlation-Id: d5271041-b085-456e-76fe-08dc96ee3f58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WNvXCmPnTtlDlPVZ5+rP78x3iO4lpOGncmIPYhMNnBOxV8bAQPNqyPwfzbIo?=
 =?us-ascii?Q?WX/rRmHuU1g4TJQHlpYZtU9QV578/rd5v7UTHQFnihIz37eqWUSGpNOQJU4y?=
 =?us-ascii?Q?B97pbsINXd5XIPRBAUnZeOvk6wibDjrUsWA+oKU++MO7sX269H/g0UVtqJXz?=
 =?us-ascii?Q?GHintQdCwYfL4cWMf4UtzMg1BB/GE8b2xTzQkm32OWkKxL20NLDVHYujIdN4?=
 =?us-ascii?Q?e4YaZtSuJrTg0MG1j+tGkg0XNITOtkpk7MJhkleY/G0zoe6IUwF3hgTk8vRP?=
 =?us-ascii?Q?frQkVBfpYz2mvi1WSHi3oz0nREybN9949SmnG/gXL95gpsj+KmVgP0gVT1c+?=
 =?us-ascii?Q?8iiV1fchVW+o6eDx3+0QzgGR66lH81nXFA4iM2iAiKzQdg7IX+MeudN+HT9y?=
 =?us-ascii?Q?HdefOdGTcsKf1ksgibvEotZdgZtK55S1hxMcv0ibNbH6TekrnftMZhTaVwD7?=
 =?us-ascii?Q?sAwVsfhOIkjz3iNsuPbZvunYIM1nhYRQQc7kp+kxsoDtJWEIQgKX1wX3SpZx?=
 =?us-ascii?Q?BBrgIixTqMMlDUcs8wNBWzC2FQdrEn6RI6nnWZuc5+kG3mcxBS2966dsmPb8?=
 =?us-ascii?Q?tAQwUMs+Pyea4FlbAiZPBjbNcambJqUmYxyYQsece9o6lvoVQluKZtVWkGG9?=
 =?us-ascii?Q?5QLgQbTx17qtHNp84OVD/EgnqDNIfZyzOAMDdC8ERPcx7vPUP4CkYj06awxk?=
 =?us-ascii?Q?T8dTDLSkoGeOqo0F1eLw2gLeO0EaNDheZnh29CV9wEt6n1DyIDClXkizpxZp?=
 =?us-ascii?Q?PP2/Hx2/bM6lH8J40z3Mbiuu3rEChp6vUyfks64o95SKj+R5/X4vjtKnPgJb?=
 =?us-ascii?Q?kffa4n49OK11/DzCTdd1kbBzfVhXXknXvv2GTK3THcTpXH/Br3Jx5R9Kw2CC?=
 =?us-ascii?Q?kuh+3XwT/C9zvLiUZauBmi/oEziOQC3sRyZUsKnF6ejmtuiRoCJxCkrq0Di+?=
 =?us-ascii?Q?clZ6kAp6H2kCaTQ3yXiEmF+73mMF+aaJDS01lb86os+Loyxlf+1znet7tTnx?=
 =?us-ascii?Q?0m72rmzKujGiyO41Go5AGPjz5CFeoOJTMmBV/4owc00Xzq7w0BcQH2nJlmOW?=
 =?us-ascii?Q?yJzaPYELd6PA4zFBqivhULzRushz1BETi/R+qtkt/oFuOYMkvbt4c7J8bctW?=
 =?us-ascii?Q?jSJA5a1iXTQ7S7LJNSCP8kTennZADFIwVX89p4TJTR60aiQbn2x7hv2bpuYe?=
 =?us-ascii?Q?6uqU+hj7bq5PzRq8nE6EB08/CoY/b1sn9ncqUfyvY7/x5qpF0VqPoldOffI/?=
 =?us-ascii?Q?Lwuy4uedjcrmpxI38YB/faUs7ThPAQXpy4JMP30tgCkv/3hMeuz78gWqAOgn?=
 =?us-ascii?Q?JVRAF+utSVCd6wdODSf8Y9qiCl+tQZon0hepDqzmcBHD2jHL3AoqndN4r2nZ?=
 =?us-ascii?Q?1zrkq2MXWNuZG7I37a+ZR++aLHVOQmda2mbilOPDJv3XJ3SnuXEZc74oeida?=
 =?us-ascii?Q?1KQPoUjobnfOQK4CVILYB3tl/puOWIQh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 21:15:18.6100 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5271041-b085-456e-76fe-08dc96ee3f58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7274
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

From: Aric Cyr <aric.cyr@amd.com>

* FW Release 0.0.224.0
* Fix bw issue for dcn351
* Fix FAMS2 logic issue for dcn401
* Fix Coverity issues
* Fix cursor issues
* Refactor dio sources

Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 55b94a72ddc2..73cdebcd9f37 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -55,7 +55,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.290"
+#define DC_VER "3.2.291"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.34.1

