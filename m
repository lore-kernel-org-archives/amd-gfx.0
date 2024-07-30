Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE16CC3DA61
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jul 2024 07:19:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72CE510E4B1;
	Tue, 30 Jul 2024 07:19:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GgoYet1u";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2067.outbound.protection.outlook.com [40.107.101.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3865D10E4B1
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jul 2024 07:19:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j+RskSOND8hn3bvBfKqFbWq1Vh8tPueJlYi+TWKz+XZj0ha7Co3k5yyrwhkbty6batW+RQgCO+UWEQU8fAZx14JjEqtkk6qwhTH6g3vp5UsVN6NdG6nTtWcKTjo/ohFFa4CdSWL6PHakeb/YlKLO6R2uw0gbZsIOIYLAHGfJlJGL7xJZvEZfBATZCd0eNBigNTEQIjqb6bGronx8Kr5cyqxHavhuhy0kyWduPd0yrXCt0auO9DSBOxhZe/NfSqmZLDpsdN6bWXpS6rNSyoGB/VWt3CrPKsoSUFqofxqE4QXAMJb9Ce/u+DDGI0YXuL3amkMJ8sSDK8/4TB4nAyppjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mdlrv+0GGJUnlcSPx079oH3pA0rJJP+gSEHFTlzippE=;
 b=ppoXYxIJ25u9mcJFaAqKL55ej2cMLUIVT6CJSXLGkdkRhRLSOCvaZ3imYnXPBhqCRMXFtczWWpYlNke24L2DzAomPwm0tmWtFGuTL4TAZheRevxhyb6INN1e28SUEgKg+yMz0bpheX/oRH98hgCnx6JFT3b15qwk7tnbc8p4wM+FzMH0g12Cp4AULtd3JwZhiZ9m1UciCr/XtUNZYvhNlSLOZ1PGjKAZkhMyauBBFqxxzkRhJqt7nqee/DhSTgxNxXILSV1uImS0Dr2SuKKX5JgLD9aettz8oHfbdb4ybf12a3W9Vnz67ELHGxXOhtZcotqcECjXPlFXx6THbIXnlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdlrv+0GGJUnlcSPx079oH3pA0rJJP+gSEHFTlzippE=;
 b=GgoYet1uogM4mGKEfdaiZHj7oh3wXc6S52u3oS3qbFp1Xk9ss+TUKHUOJCQR2ConJay8x/qEKaaXvGWcPu7OGoG7EkSlOIZo98WOJCUa4eTNA/EEHpwxxxLtzhdFDOxYWUUUqYou+sUUzyZz6/T9ASSe5d4ZcrEK1vz5rtLWHI4=
Received: from CH0P221CA0042.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::26)
 by SN7PR12MB6911.namprd12.prod.outlook.com (2603:10b6:806:261::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 07:19:43 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:11d:cafe::bb) by CH0P221CA0042.outlook.office365.com
 (2603:10b6:610:11d::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.35 via Frontend
 Transport; Tue, 30 Jul 2024 07:19:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 07:19:43 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 02:19:42 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 30 Jul 2024 02:19:35 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>
Subject: [PATCH 04/22] drm/amd/display: Remove unused fields from
 dmub_cmd_update_dirty_rect_data
Date: Tue, 30 Jul 2024 15:18:25 +0800
Message-ID: <20240730071843.880430-5-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240730071843.880430-1-Wayne.Lin@amd.com>
References: <20240730071843.880430-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|SN7PR12MB6911:EE_
X-MS-Office365-Filtering-Correlation-Id: 673ebec9-5dbc-4f0d-8fca-08dcb067fbd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9Nihtrri5hFnS1XdymXmx1WHvDQkNUp4ltZI3eJtsfVQOAt7+G0nErOkYKfx?=
 =?us-ascii?Q?m8DKuECCr+DTMuPZCvuRmE5KXgIyPncngdy8IgpCbEfw9/I02/1donRn3OdR?=
 =?us-ascii?Q?2uJO3jR3p5Mjwri0jiToGuuoGr1rfFt6O9Mbhx0JXZMun+YBeF6twMbzFMbd?=
 =?us-ascii?Q?mmlURGNAOo9EzW+SbWk7dVRFYxnKiYsCERr7duXl2I/xpcAIEPC/5GLBys/X?=
 =?us-ascii?Q?UXgCajIUVdr2YPn76vhhopVwjCp8oNdD4DY1HIj/wUxBMRQWPYSPjeNyp7MJ?=
 =?us-ascii?Q?EBPnxweinWGyf1QzpaWgB+sW85v3N3uzcSSD/tHCjLTi8pFyyeh9e9lGTIwx?=
 =?us-ascii?Q?ZVP+0QBnKv/eHrIDon12J0mAortrkFRHQC4g1F1MHfiMmPTh7LXdj9isp+tz?=
 =?us-ascii?Q?kwdoohxAKXrwqK7TfZMfotuolRQy8e05BQqYKkKPd2mi0MZY2bo9jOF8YS6j?=
 =?us-ascii?Q?cdT+bJkVIk+TM0udNFO6FyqPRvA3Mzk0XqigAzWUMdsagHqUeW6gA85zhrif?=
 =?us-ascii?Q?0BrmAecLlWOFN3n4dChKBeg1gYmrd8O4Ei0EzDNC9Anoh8oXmRprrp83fQIE?=
 =?us-ascii?Q?xu/I6Tv6vY/hlbJisaygfPkUJS/wX+tMvY8UJdfPF+3i+lyVyUef8dVeg1WG?=
 =?us-ascii?Q?XxhFo+eTECMw5dl9SFyW6oXAQ6YQfs1JlejvF0cYLarkd4NjBPnWBCT9pvpY?=
 =?us-ascii?Q?RuatssjqGNYV1bfsR4z3a42JhfiXSnSSubZqL70jkDbDIMt0H+JJmQUWTdnC?=
 =?us-ascii?Q?Vf1hZQY0UG0mJEJA/zzy9v1q+6+Ki4mFvJSJ+JQpM7bOyDevu+2D7YAHaJV6?=
 =?us-ascii?Q?tVccjT0nc5aqgZ6hW8s1SiG4GeudscxM4+JuHN9oA6HblW0BlBmiCZhWayp6?=
 =?us-ascii?Q?7eEUS9ujJ7FEdjWlEsCvN/cnVAP+c63Rgqo8ROJqpdAHRYyqLhQH/iwWZqrE?=
 =?us-ascii?Q?23TeT/uufGvx0MtP2V4jAwNbd/GW1P3UYHY1pykSYaaxlsN6wOUO+lOnz4bO?=
 =?us-ascii?Q?5uFjiToLc+88DdoLMXlf9AGiBOWEkww12KC45fuJ9X/IZdKkxFGwU4wBkvvW?=
 =?us-ascii?Q?duIaDRKCsLvOFRnijuwPxLy5uPVvXJE0YrwFkbzoiVxcUdoNo07u4xryI1xV?=
 =?us-ascii?Q?bdf+g7+9y3epZuWemNU5fq8TCv9sOsmXfBGOpebVH5VxOFaAKK3VH56j4qsJ?=
 =?us-ascii?Q?w4F693LWJoQKyWuji4JnP0veX77krJmhgQm71JNBvmtSYkyBTOzucKqIIcX9?=
 =?us-ascii?Q?QsT/WPBmsi59Acsso1xAkYh6oGqncthlH8AGwqclIYW4PWEhBffBS0kg9Igt?=
 =?us-ascii?Q?R5jjZHUuDZw+v7nwRA1w9ARo2U8OQHgr9CiXPpZAnIPY1ZE4tFVnz13+eabZ?=
 =?us-ascii?Q?vFz53/R//O8iCjay6e82kmtDrFp2Mf/aHrNHCRP0hJ4SdzsWluuLgxB8qp6j?=
 =?us-ascii?Q?wqICQxkcqsoFilZEVY7ecn6hvlplwS8E?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 07:19:43.2249 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 673ebec9-5dbc-4f0d-8fca-08dcb067fbd6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6911
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Drop coasting_vtotal_high and pad from dmub_cmd_update_dirty_rect_data,
since it is not used.

Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 7c3838362c49..c5f99cbff0b6 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -3028,14 +3028,6 @@ struct dmub_cmd_update_dirty_rect_data {
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
-	/**
-	 * 16-bit value dicated by driver that indicates the coasting vtotal high byte part.
-	 */
-	uint16_t coasting_vtotal_high;
-	/**
-	 * Explicit padding to 4 byte boundary.
-	 */
-	uint8_t pad[2];
 };
 
 /**
-- 
2.37.3

