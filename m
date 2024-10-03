Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04903CF34D6
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Oct 2024 23:36:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A66A910E99C;
	Thu,  3 Oct 2024 23:36:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KgzAcVPL";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2082.outbound.protection.outlook.com [40.107.100.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3062E10E9B4
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Oct 2024 23:36:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JKrM7dX51hFkMTwVAOJptFmbSyyZdtFwh+8lxb4FowOHPNGkAAW5mQNuPP+05DuicLOT10veWrDd8R8VlqHpVYVuEto4nKtsq8YsaWUVYMgg4uqK6ROVd5Gjt4hbQSdoMmFtiUKuoAAyqQHKgDbo6bYq7RYTbIrRlIIYO0+dWRsdBNVDJtiInyR9/YGCuGvL5sOgwUfPbt82xlyHOWSmQrKhfuVnJEV8j74WTl9fi+9xlP9kiS1hNHRkEdJDX9GGk5VNmHfzofvzmsHJ5F0nbahCNSbimIIenVJxHZ8vZnMpQleQ2qsHDDx5QNqJvtjMTD2W9WI4WDOGDrZoZPRsDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NfyWeESd8Q42+UWPuu6BGjWlA7hTIG9NeUC216s4OR0=;
 b=K0TT0+ned4qvGyfKPYkKSitL0E/ICcOHJR0ZmTGqmxoZoGkCkL7ZdjbrjPwSDdhXPxWjCemtFFIS2qBKU3zpsRCwpOoK71KzOwcf/vzbDpUUtzjJ3hwaZfzj7Mbi7iD+FbtXf5l32TFLv7mZqyIrukwKgAc7Uwk7RkhRT9OCKA7n5kI29kVP+4XCA6BdOAA66aq+YuFeqRJC8NGqp6LuiHKLhKORcAriPMrc49Xl3iKM2we+r478Dl1R3y/rMHcLUGcrJzWZrrp8S4N3LS/GGNqge6MLN4x3YO6n3Q/jHp6ygyTU6r241NOCZCtIdNxAoN4x2pD4K0BQk372rlM6ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfyWeESd8Q42+UWPuu6BGjWlA7hTIG9NeUC216s4OR0=;
 b=KgzAcVPLLdDodk84PX4wOOYO3MI+MRrPBIPMCyP/KTrUFgqad9cgaekkz/TQe82xs92ScqE2EYZWfp5xYShPqDpswVX4Ui0WAP778/Je+djeT1An2wu7p6Q30ZvYsDJjLgulfX/rk25HkuxELv3AZ/q6zuf4oridlcselKzu/xU=
Received: from DM5PR07CA0093.namprd07.prod.outlook.com (2603:10b6:4:ae::22) by
 DS7PR12MB5886.namprd12.prod.outlook.com (2603:10b6:8:79::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.16; Thu, 3 Oct 2024 23:36:22 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:4:ae:cafe::ff) by DM5PR07CA0093.outlook.office365.com
 (2603:10b6:4:ae::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18 via Frontend
 Transport; Thu, 3 Oct 2024 23:36:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Thu, 3 Oct 2024 23:36:21 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Oct
 2024 18:36:19 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Aric Cyr <aric.cyr@amd.com>
Subject: [PATCH 26/26] drm/amd/display: 3.2.304
Date: Thu, 3 Oct 2024 17:33:44 -0600
Message-ID: <20241003233509.210919-27-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241003233509.210919-1-Rodrigo.Siqueira@amd.com>
References: <20241003233509.210919-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|DS7PR12MB5886:EE_
X-MS-Office365-Filtering-Correlation-Id: ee96b95e-2489-4ef0-f8d6-08dce4043023
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wYakiVihYsNrCI3VOG+9MECnHVFvsDF44zuImpVv9TJVl3ifUoeo+UBQD1m1?=
 =?us-ascii?Q?AE/p8TcDqdRKo49NE/TRTUu4c9XHyf9rJ7WgNGlkwXsCXxDpD59pmdiLCnNv?=
 =?us-ascii?Q?IfqkBhuu6aPQsKf0oKYljxnuLAT4dmILwHb6azeOd+Lijfs2yfwl3Q59cHzi?=
 =?us-ascii?Q?n4ULmGu/mPHWQjKFqS29DO2Nx5k4EzacRBh7TNCu7Rp3cNchPP9t76RhJ0BV?=
 =?us-ascii?Q?Bdp5xM0BbGSzLHMLnMXXcqziYpaJMMyOWHuehM3m8IexfGqJod+suHat2wPY?=
 =?us-ascii?Q?cZ31f373U08VgOsbouXyavBtThU1ftApOU149nZd6W6iVaSSjHfAaFQVOD5y?=
 =?us-ascii?Q?Xq6DqpOdpCJ3DvXJhd1O36mLOaQiwzfWYy9AUALYlhVGFYZQsJA8Zf5RSgJB?=
 =?us-ascii?Q?A9EgqT3LX8r/lHw3YqXOlsnnq8fi5U9DK/RGMz9Fj2cp9uvcZhi4gzoIerUs?=
 =?us-ascii?Q?lpSB45ncdaav8cVXYSzGV1H6W8pbR7GY4Or9Y3G0PtbiHAiAC7N5MKyQNilS?=
 =?us-ascii?Q?m4clPOKvj4TcZNxJjY63rJQqbv6XY9rs2cgTlwsu0pCLALIDRw4lR7yEPBXd?=
 =?us-ascii?Q?KxHcuYSekh/iymfYY9nxmwaIfQOJDfNzYKadCXRurszq8XfAb0vUpUwevLmv?=
 =?us-ascii?Q?qi5+ncJK/yecbuRgGoZnGqpw/3YCLSihE9Xrb2cqwwXLkVfK7BBjisprDwKc?=
 =?us-ascii?Q?acpDSTKh7ghtTZfIRsqyEzPikeeCmmkbVvEDeUEUq7Wij9Wb7lN121lBv1AM?=
 =?us-ascii?Q?5nPMhHr69CUoVqYzUbZNkfDRH00R2RV5nEDe5KQF3uqDF1yN48ht0MyXfrMo?=
 =?us-ascii?Q?e1jVev4WDrncvPGEh+Sb3FDZHphd4eulQqRaCWij6LZHtzcc07JMOugr5of+?=
 =?us-ascii?Q?PH5mlPk1LxMFyNrkyfD5cnggw628oJVb5n0UkeIhVt2iTRuO0q/+3KXEIyy0?=
 =?us-ascii?Q?x0h9DSSUOTOkgYZxXUraYCHD8o29mV8tk/qjqWY4IlpBrILHrnGyrYXnzxRj?=
 =?us-ascii?Q?vDGAmLvQgRzLIjdgxt1lMu4RcVgVAMOHrtzJ/SofGQNdnlPgVpeN9KOQYp95?=
 =?us-ascii?Q?uAe0us+Lb8zjMpM4sld1fW1LqET164BBkSLsNJGoMP95p6HjWnJcRjfyQZ1h?=
 =?us-ascii?Q?XjpJZW+2lQhZRwipaEg26qoWChP5MUlSf5OuJNfIGRREtmaBAhVzXhEf2Mp2?=
 =?us-ascii?Q?4ZsOY09O4ozWWmWDCziGbuYucZrJawU6RQVH3ooU8RBFRZQNIBcBEqfiqDd2?=
 =?us-ascii?Q?EQsAYhvGS8TebdYL8nbVqnJGrOeYnm0TORkR7GroxY5aBWdk30GDqZcW5uDI?=
 =?us-ascii?Q?0Ozt63oH1v9Pt8OYqeJfC3vYiYrsasNxxBYzViDqFYChoURdvJrrIkZxKZBd?=
 =?us-ascii?Q?gnfAwHgZSKuY2inymT7pj7EJ5QBU?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 23:36:21.6402 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee96b95e-2489-4ef0-f8d6-08dce4043023
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5886
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

This DC patchset brings improvements in multiple areas. In summary, we
highlight:

- Improvements to seemless boot.
- Adjustments for DSC dock.
- DML improvements
- DMCUB fixes for D0/D3 and new register offset.
- Code cleanup.

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index d80c91eddc75..621444a1f190 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -55,7 +55,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.303"
+#define DC_VER "3.2.304"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.45.2

