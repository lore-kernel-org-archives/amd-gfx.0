Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73F0AC25B5C
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 14:34:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A3A4112CB7;
	Mon, 29 Apr 2024 14:34:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vzKdxLIz";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2050.outbound.protection.outlook.com [40.107.100.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 948FA112CB2
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 14:34:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJF2K2Scghm/D55gQfXXx1i4c5qRPVkaOBJbNCr8yGHR5DSyBB0xxNsz4xQA8KgbI+nh4NISdLUDOwBNh+pBRNofxl06T7SyVSbU1SIFvr/RbhZrSRxOgKqFD6GrdN/CrvhF1bzmmZ12dmZX7fivcFMZCkP/a7RrqqZ899nshwpN9gbzF0PXsgjwhvGLcM+CSaZIz2XczAGjAHmpgEo7pBRy3ewi46vFdVEuJ7ut+egsUd6IWNYrfvNieT8AA0mtUyHeQDNQrXdlUC2Oy89x8G1olBsCRm/AqhdZPAVQGbBai0EUgoUpGAaflz8OMCYjXTmp12dp7L1YB1uv1bKo/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/tqtQ3axez/rFhb8iroLcsxuXWKIEB1WMw8vXvVl4nU=;
 b=Xk+cmBOF9bZS/EcrnWrUYu4udH5fN5PSb1qtIY8XPo9iJK5xiFEhIkDImD8zRlhTJo/ods9oBhGiyJ9WQ8DUc5INuRfnrHDsAa2I3LsEiai/DbEd+Fpa0Zwtikh8wbs63nxup9CtRGmHF9eQEP9s58ZX0WMEPvhKZXuX1SLY37I6TVUhp17MzQkc68c1V9mdLk4L8CXjlHVV4xmaYv8BuckCcxucccEalzH9Lwqps25K8zG77oSzUkI7KElVDPMkHQvWBL3q4tRubTmfk1W5OW58jfIryB1BpepH/ejS+0MbMfhlVpc30djMxIGsv7jFshPm9wUiD9WMuD5ZHjaong==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/tqtQ3axez/rFhb8iroLcsxuXWKIEB1WMw8vXvVl4nU=;
 b=vzKdxLIz/I1NH8i29oJ/GIVY14xhVEdpsnIM6gpIbocX2D7cttUb1a1CwCzmsHP4syCYOGzL3Ppq2MpNPk/v4D5m2+sO7upfbNJPE3bKIIi8z2HfwKkskLo6czW04tjYMhXJlqNp2G9xGMPvZuzEHbCVvbnUmFtF/iXXX/76j0A=
Received: from BYAPR06CA0010.namprd06.prod.outlook.com (2603:10b6:a03:d4::23)
 by CY8PR12MB7634.namprd12.prod.outlook.com (2603:10b6:930:9d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Mon, 29 Apr
 2024 14:34:26 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:d4:cafe::16) by BYAPR06CA0010.outlook.office365.com
 (2603:10b6:a03:d4::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34 via Frontend
 Transport; Mon, 29 Apr 2024 14:34:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 14:34:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 09:34:20 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: shaoyunl <shaoyun.liu@amd.com>, Harish Kasiviswanthan
 <Harish.Kasiviswanthan@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 31/31] drm/amdgpu: Enable event log on MES 12
Date: Mon, 29 Apr 2024 10:33:39 -0400
Message-ID: <20240429143339.3450256-31-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429143339.3450256-1-alexander.deucher@amd.com>
References: <20240429143339.3450256-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|CY8PR12MB7634:EE_
X-MS-Office365-Filtering-Correlation-Id: c9167198-629b-46c7-7262-08dc6859784b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|376005|82310400014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?acerscmhfp62QUgKQbC3mXrOd9Oeo3NCf00qYusG1JLNX1tUgM7L3rpQmJPL?=
 =?us-ascii?Q?uYPRpvFbYIwgDlLgZVSHBAdnzMQmki+Sr53YH/9OS97A5EQcVz/mnF6D9jej?=
 =?us-ascii?Q?H7xSZSpzpVDZFBgjQxLE/1qeFHIyfhkm7d6EuodaOdtnBa0yIht8TD7Pk9r9?=
 =?us-ascii?Q?XiGQhRE20hj7D4xhy0J2vEODL3bII6wCUHgyMOPq9qDWAoo4a0yIKGllsOGs?=
 =?us-ascii?Q?NDviTA2xXm2f99pllQ2geoehdv93slzbWos9XYYMfYc7hyHLgETmD4w25Ti/?=
 =?us-ascii?Q?cYybvrpFRlzMrX1QpaBVob+lRhdV9bLCBn4EkEyq+5f5Bfz3tF+/9VztXu5g?=
 =?us-ascii?Q?ZkRqNXHW6gMPYCHv5o4zKweByS27y+haZAN1rDszHfacHbClNdtpZoLOV43U?=
 =?us-ascii?Q?V91yrlWnOaAmyMnF5Z+9Ore97Z30YPRIs3HRcQ6Kqw70yyYUsdNcJRBJcnuR?=
 =?us-ascii?Q?ZmbH8ymQzKLx3f7T7uM7OTsnnFSyc/vcfPXNmXx4zdqr5NTWtx0VHxjaYXpq?=
 =?us-ascii?Q?4igGglFwb3C8mMCZWnLqzc+fOv9GMv3IT3PCfH9c0WlF3J9w6HyuJC/FK77P?=
 =?us-ascii?Q?H+lCZw03tY1FbOTDwbOU7V7ibBBvmNF7IJQwTUw8O7zcBjf+aEAuM5lL/PPn?=
 =?us-ascii?Q?cGm3b9ho+tASW4tpl+8xd42nrJDle+6Z682r5HX+YW820JpnpbOv+wan2dAp?=
 =?us-ascii?Q?zu/OIM5apRDkgUCWHA5r/fsniKas48+VN5RjLeoW3RCIheMaCFC0n4wJYx4v?=
 =?us-ascii?Q?Z3DucWQLyfRisiGXCH3LAaxMXP0ddAWigWN8H33C6jqHKiSYtP1BzI6sVfR1?=
 =?us-ascii?Q?0eXzsL2NavLDSjlnEgLQCaMR7KD1GSu6nc3obZ+wI2Iyux+wPNfDwUbFpCyk?=
 =?us-ascii?Q?+mXkoIUJkQzFRnggIh3OdHx41Ykm/p3PsEzhIRU59aa6h0tb3y3EDXwtlh0b?=
 =?us-ascii?Q?IJtjyMAbC3tFXQ3MGzxEPyXM7BZVKd0lRoHEiFd5VIlowtv+RfHqH2OvtAPl?=
 =?us-ascii?Q?QGubG9zwVUj12kLyA2/4jcjAX+4/KPXvjpN3i0l/cBlBSeqUG6t8SCpY/9g1?=
 =?us-ascii?Q?QrgvMEEmW08dXKUpXqfnbxDmV2bHeZx1kVrpAGTSA1E0TDQ6xIa4gldhOWiA?=
 =?us-ascii?Q?8Dg2brGOIB4H16oKSrB6a5lL9IoC+a7GJmLiVKMsEDhmESOnLiLmErEAntv/?=
 =?us-ascii?Q?0yTXf0SAX2onV9PA4liiKYx2S8PPn/8ONK2j6CWY2k4jWsGU7LgfSjMAhcsw?=
 =?us-ascii?Q?hHf9C2PggbugBsTo06EHau0NILN0M7KNVBYqiZdWDSokaNfJh7AtTG8RQiXS?=
 =?us-ascii?Q?JUtv8KAepazaG00wOE/N8/U3HCAVDi6aiit7wO+hzhscjaPe607vvTPOtT/s?=
 =?us-ascii?Q?IbmdLZ5n7tqmSlIQvuiz3ZIXIAAV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 14:34:25.8106 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9167198-629b-46c7-7262-08dc6859784b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7634
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

From: shaoyunl <shaoyun.liu@amd.com>

Enable event log through the HW specific FW API

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
Reviewed-by: Harish Kasiviswanthan <Harish.Kasiviswanthan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 4a041cc22f68a..e92478b1f298f 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -403,6 +403,10 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes)
 	mes_set_hw_res_pkt.oversubscription_timer = 0;
 	mes_set_hw_res_pkt.unmapped_doorbell_handling = 1;
 
+
+	mes_set_hw_res_pkt.enable_mes_event_int_logging = 1;
+	mes_set_hw_res_pkt.event_intr_history_gpu_mc_ptr = mes->event_log_gpu_addr;
+
 	return mes_v12_0_submit_pkt_and_poll_completion(mes,
 			&mes_set_hw_res_pkt, sizeof(mes_set_hw_res_pkt),
 			offsetof(union MESAPI_SET_HW_RESOURCES, api_status));
-- 
2.44.0

