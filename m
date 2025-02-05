Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFEC6C02192
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 03:38:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D86110E72E;
	Wed,  5 Feb 2025 03:38:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="017DC3vd";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37A6510E729
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 03:14:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ijxanhw7W0ssm4/pI8OFbkMuylnBcVab5e42w9AwfR7lKIsjeQ9ywrzy90z7xizeFQ3+xl/IXyCBKeDQ3DlTOXKzM2//V0Gmh/qanPrAmFevUmpBTyWj5Dc6b2aJ+fNUGRITXPz0b8xbxvUyz8FoNf6o1MInAobGWRGDOw30Mi3YMtrLnwqSg/izwXpxyVwA8hrwHfrUY4ex620ic7lxqvMfBWag9fVP0sfzgyk6mmeKz5xrwBg6x27xumB2S9KeCTSzUli/02KKwBmqaiq1CccAtr8xFSBjMRlVBlhJW0esmqw2w34hX+C3EhZontBHOYnieWgN/xISJZ0gZoZtow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ubwj/VOnq9g82VombPQ9qQDZbXMek28nYUA1EJGpmbY=;
 b=fPDmVUHOxxm/ZgyiVzKOinezsVCEwpjGNCMNwy+iz4/cS7Pr12ae9WkVg4R/UvnVo8vlbBnh0Tcj2wbjmkETEfLeuSdkQfnTW+Jn6a2fj3cd5a7nzP7wPtT1fF2nNpOaqESSAcI0whhWhKu7R/xGBjJeb2EW5Bd49nJ0bDMSidX8pN/ccERyhCc5TrA0EsBX8lHZO3mVZlMb3+w1BQwCFIMlsBmdQqEK8CVnsrcPYr28+ZTJ+wUK/KLxwYtSmC3n/RqJgNni8SGxUA8eHeiZTDKXKmniJcUAqfWJ7F4oMh3Hdlz+WrAlmaeTiNKuoZFWZ5HJrfpQzbIn0c7pAqIg5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ubwj/VOnq9g82VombPQ9qQDZbXMek28nYUA1EJGpmbY=;
 b=017DC3vdYZeWpevs0gFyTqR5oQfZI2bUE239Hr393Q4+TvOKmwrJM53EvacJECSxwMGsXoQ3f4xEeUJsg7GkQcBvEY4pXupIAYklh6UR4VXpb1WmrQkY3Fw8gIlfGQZZI9D9O8wBWIJ1GUR6AWBMAERd4VE8hCe3MWxtXx6gR9E=
Received: from SJ0PR03CA0272.namprd03.prod.outlook.com (2603:10b6:a03:39e::7)
 by LV3PR12MB9120.namprd12.prod.outlook.com (2603:10b6:408:1a3::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 03:14:05 +0000
Received: from SJ1PEPF00002325.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::c9) by SJ0PR03CA0272.outlook.office365.com
 (2603:10b6:a03:39e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25 via Frontend Transport; Wed,
 5 Feb 2025 03:14:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002325.mail.protection.outlook.com (10.167.242.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 03:13:34 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Feb
 2025 21:11:45 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 4 Feb 2025 21:11:41 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, Harry Wentland <harry.wentland@amd.com>, "Leo
 Li" <sunpeng.li@amd.com>, Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 "Tom Chung" <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>,
 "Zaeem Mohamed" <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, 
 "Wayne Lin" <Wayne.Lin@amd.com>
Subject: [PATCH 10/12] drm/amd/display: Support DCN36 HDCP
Date: Wed, 5 Feb 2025 11:08:55 +0800
Message-ID: <20250205030857.2608094-11-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250205030857.2608094-1-Wayne.Lin@amd.com>
References: <20250205030857.2608094-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002325:EE_|LV3PR12MB9120:EE_
X-MS-Office365-Filtering-Correlation-Id: 6df9d7d0-755b-4c1f-4f6a-08dd45932480
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?r5Taws8IpOa5cmUcCkaot7DjSU7fRo/jaYVJSC1bw0+LlVggY8eN0S6mrq3Y?=
 =?us-ascii?Q?zhZeVuWbivmSgHQwy8aT/FAGYTKk+DMUGBmdfggxnSFwLMG2JMI90hEC2/XS?=
 =?us-ascii?Q?sroxm0iptdTx0nX/QhqdNFdBHd/VYy1JIhgRhWVo0yzWM78DxqrIVMcd2k+0?=
 =?us-ascii?Q?dAT4hUWl/o7Yx8IbErtrpnqL6TkWx2iEj1440gyYp/EHrDVGm6Gn01CPzT1u?=
 =?us-ascii?Q?cdoQQC32oM3SKpfKKBSwigf5E0DtVm+oqiZRjExTK2NVHtpJwyOM55ogMXXH?=
 =?us-ascii?Q?E8pwJ4NPJTpCEemMJB1DtpPi7+YMcQDzVBN7+IpN+1O1JqAxvOh+Z+4YxUvN?=
 =?us-ascii?Q?m7bL5eAiLFhJcKIxjOMsQvhmpF+yAA1K91qz9bd9YySppu1vwVh5fWuNdyXy?=
 =?us-ascii?Q?C5CIBSOyYJs+dI+/gXMcQSwPc8Z52KRFQ5G1APfXnwZqejknqta2YyxfXKOP?=
 =?us-ascii?Q?NaJVJeEQ8uxMvCcK9PyJOnmiWSmhrvK9C1Ec5o7kLEMBq4MWtI7d7NFI8TvC?=
 =?us-ascii?Q?L4zXsxq/Z60y4SYiBbxCMxqlzNc1F0ZUwyN9TcuxvPERdKkUFXzT8Hs+pvfk?=
 =?us-ascii?Q?G39g32uEOFXBJhtIgNty2NGW23r+UPuYAqX+iXWOvouGt1mUk6LR+FGpmGyx?=
 =?us-ascii?Q?wDdd2CROKA+16I01HeHqRG9z7MTioJncm6oNjMEMEUWgAB9lra+97SBHTBde?=
 =?us-ascii?Q?YgQVkG28CBXzT2R0tZ4L9aLWWgjMS/66DOanUjKoQjbI20aLjqNruZYv1i+K?=
 =?us-ascii?Q?vCkmJNGbjILJdy4JU7QZRdTt4x2o/yyekCyc+bbiULAEuQeFmc37xsMhIKgR?=
 =?us-ascii?Q?xjwSlzD7UTp/nylputcCB92qXRtLowNU9kadC66u5mgKm4Q1GqVCLBRQXqNB?=
 =?us-ascii?Q?Aat5tTc2NpTEtLNzS08aTedVdi67XO+i01SL7uUqWwGwI+UAbIbNSY5ENy82?=
 =?us-ascii?Q?JQI2yF6nwFtZ4vF2a2SNu0iwoN7+rKzYSe4pdR+SyAnEP/RLKbLNhc+bKhRk?=
 =?us-ascii?Q?zHJTVsCaej4K0qDjH6RImUDmhoqzHBd0u2OcsrfUfvhihGy+jtdvhiarR8m0?=
 =?us-ascii?Q?CrrjdcmfIWMAG4ZAzdTKSKVVH0cGB/L3WaTBdAm9N0Mpskz0wQ8hMSFTp7Vf?=
 =?us-ascii?Q?0PuT90tq+UUf/rtxRE2T7vIYo+xHthJ5bGnhOZq0xhDTigq2bpzJfUlJCS1W?=
 =?us-ascii?Q?R7EqupUDmx2656CiEVevkdKaXNDn8LLlibGkARAnYo29hG7NN7hrTYIyDzX1?=
 =?us-ascii?Q?pkKvkKbNh+zdhZhq/WZqaO+fbj//CWx2OKa8mRfyeL/SaHIYnoqnk6800iHC?=
 =?us-ascii?Q?DKBpi9EMZsYceXwihNpwsXK7Rs03ob2aPCc4Wu7GUdF1RnnrGt42t0WbGgh0?=
 =?us-ascii?Q?LDh/EvomVm7X5a2Tv5RO9sRawAQvM6T6G5JvhWRiDMNwywkRw60mP5Rc8SEn?=
 =?us-ascii?Q?5Y5MpLPYlu009N8VqQeKN0mlwPitWn6tDStUrxOxK/d/R0yfm5Am6JExdAkb?=
 =?us-ascii?Q?rJhNtmLcRtNBDa0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 03:13:34.9810 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df9d7d0-755b-4c1f-4f6a-08dd45932480
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002325.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9120
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

Add case in hdcp_create_workqueue() to support HDCP on DCN36 as well.

Acked-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index e339c7a8d541..8238cfd276be 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -742,6 +742,7 @@ struct hdcp_workqueue *hdcp_create_workqueue(struct amdgpu_device *adev,
 		    dc->ctx->dce_version == DCN_VERSION_3_15 ||
 		    dc->ctx->dce_version == DCN_VERSION_3_5 ||
 		    dc->ctx->dce_version == DCN_VERSION_3_51 ||
+		    dc->ctx->dce_version == DCN_VERSION_3_6 ||
 		    dc->ctx->dce_version == DCN_VERSION_3_16)
 			hdcp_work[i].hdcp.config.psp.caps.dtm_v3_supported = 1;
 		hdcp_work[i].hdcp.config.ddc.handle = dc_get_link_at_index(dc, i);
-- 
2.37.3

