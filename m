Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D199AC3064D
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jun 2024 21:14:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 668BD10EB55;
	Thu, 27 Jun 2024 21:14:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5J85bA6X";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34E6E10EB46
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jun 2024 21:14:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0z4FTSibAV5vWrsbqOw9XqAUC9w38MlNxpxsZwlLWbCtlRUrws4/X5E6Om17FZIdaXvMuRzZXfoKx36evzfTFomGYdRzUoZeNJjZV0ksRcnOGBDOWfg5RGOPgbrLrGlmIRU7To6CTUuatDe9Kj2y4CE2nJLQ/RBKdARanAtxTxkDE1NTbMjKOkJ7/mZyX7x6sPWH3Oc8FqT7a5zLN6pNBQ9DlnvBLl5H+FqciKe6Kad1n+jVE6jDh8v607rkbrIEBWd+GVQN7ShCuWCC8XlH7GHguFRig3pzI7KmYy7sUSIdCRHfiLXHq+4xbJ62Gh2kTJo3vpxdGFUs0uyoj7FVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OhyljBh3MHdlv1lAaBax4f/6vzbzY0XeUZTbVBjwNCg=;
 b=C9cmhBhSb/y2anVWZTtKqmUpC6bvCRYrQT5haw3KOL+3D47KvqYIMT1SD37fH+qfVTTzgNX2cONXWLTypv3byvWih1JldhL7Ie15u4Hs65QU5SRaGuppRcRwiAnPPVWwD72sZsjniRhE/uk+XVbFnaLSQezvLLe0KV3I68ohf+XKkH4w6Znp9FSC9zjleNzHSVU2WvHDHfeqxT11GGQ25gSGpDUfrciQytTXFH9k99LKZ6GGYCheI8VcdeKtYNfz9FFd5Anv9cGS9l8zomuaYqlCVfa9uYljP5WI+citV7I9gtQFJlW0zD5WyBj+VGDJiEpKqSvqkSKOjcLomPT1pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhyljBh3MHdlv1lAaBax4f/6vzbzY0XeUZTbVBjwNCg=;
 b=5J85bA6XNAczTkMD9JUS4HN61NUbzgXX9YFSaBLIwgT97Sho+BHjswjufehxbkFHjRbba1SyFy5Boog2PkkdXXFHsYOr7k6GL6IbdzFbHsaI4PTTZZuDO2PU8Te9/cG2/vaNzEPl9x5LgZGCICzDibtHzrSf7Ogtp/KBeuBB7fc=
Received: from BN8PR04CA0002.namprd04.prod.outlook.com (2603:10b6:408:70::15)
 by CY8PR12MB7123.namprd12.prod.outlook.com (2603:10b6:930:60::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Thu, 27 Jun
 2024 21:13:55 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:408:70:cafe::a2) by BN8PR04CA0002.outlook.office365.com
 (2603:10b6:408:70::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26 via Frontend
 Transport; Thu, 27 Jun 2024 21:13:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 21:13:55 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 16:13:54 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 16:13:54 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 27 Jun 2024 16:13:48 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Joshua Aberback <joshua.aberback@amd.com>, "Aurabindo
 Pillai" <aurabindo.pillai@amd.com>
Subject: [PATCH 04/26] drm/amd/display: Remove unnecessary error message
Date: Thu, 27 Jun 2024 17:13:07 -0400
Message-ID: <20240627211329.26386-5-Jerry.Zuo@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|CY8PR12MB7123:EE_
X-MS-Office365-Filtering-Correlation-Id: 4526fb33-a40c-41ef-6fe5-08dc96ee0daa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Dk38gcbZoesPvxg67lQOLd91qpnluLKWj3KOMvxVq0E34q0h9iDvXIs1qRd7?=
 =?us-ascii?Q?hRIu8/938RuKW/ypCG+pIjJB9c/O/c1QEzRv4TY5xEj0G7J1HE12SO+ZHW/R?=
 =?us-ascii?Q?WABJRcoBAc0A7n6lxt4zetgL9RQaoRRgRA/U8y4EFDWXkoWW0RFzyPYcf/Mz?=
 =?us-ascii?Q?d9EM8LvL+0Eznh2JrsXuBJXGjj0Zmrb5rXXAvxIlbnUIEtxkW85lvUzZRzH8?=
 =?us-ascii?Q?UaEIejyxh2JAf/C+4f5Mcf1Ejx1sGG02V3iSrMpHzxUlxgjupypuaVb8YoT9?=
 =?us-ascii?Q?ZVfnHQMSodDfPTPx9Ig1PhSX7NemgcuDKzWU7Xztn14UDimtV5s9dHA1Vy23?=
 =?us-ascii?Q?gvPErFAhjoRea5/MF1wFg9CWTeCdTEHmJAyLs5sYHv21Z5zQ5uMT6b2c7+Vh?=
 =?us-ascii?Q?dIySdl4Oa6rR8sYLLEjl/gIBexJvla4T+qbvCyW72j/UJwXCjnyWtnSVqEae?=
 =?us-ascii?Q?B6es1uBjY6FPg4YWpGd141ZWAGtafAnEe/Xo1Z7nETw8QJNhOOri8v6LqqmS?=
 =?us-ascii?Q?kmwqy+gxdivQapxeouRKgsbZ+9fjApJ//eR3DSrsLH9uBT/0ayuPdqIxW7ue?=
 =?us-ascii?Q?QVcecUZ4jkgXr3gJ0vpTDlgvAkSs0SuEf0CPRHoRKH2I+pMIqmVHyfZa56JS?=
 =?us-ascii?Q?IpTrvAB8ubzpwABK+/Y67ie0mkqnZoUFtpx34db7q+QfT/V7rGlJMsTPt5sb?=
 =?us-ascii?Q?GjioiLe5fLhaBpYeFdxe3ehVQ8/lGznL1+JcHTg0pX3w4BUMD1zELFy6o9yr?=
 =?us-ascii?Q?t0GXiX0XNcx5OBgDtcgaNe2djdMTfPjLh2t1rG1GuUcJx70sfLlju6t74b9Q?=
 =?us-ascii?Q?72UtaAxg1O0o2zPiPQgaCeyvx0GFdrlO6mn8YxtHDmteHRGsh66Lh0NJSG0c?=
 =?us-ascii?Q?ut0L3F1V9J6vTvNu5l+bMFYlsqh5+rOJED+qSOPomk27/s3xObv8Kdv1bbVd?=
 =?us-ascii?Q?EURaUl+hp6GiNX72w/yYqKIqH4LE37W8cXXjmf3W4kjTiHq+qtXlMd4zGuSA?=
 =?us-ascii?Q?a3x/d5NKzxpaauYTA8ojDQoAQZic9HQgjYkoh/6mTAMZKb6PNqwHIMO0xlwJ?=
 =?us-ascii?Q?Ea4zcIjb8fcU3UOVhAZOVc6mfeGoFjy1iSa96S+oJbVZklWL2IhQ1IWXDLEb?=
 =?us-ascii?Q?pkDGRsGq2ZiK+mLwW6T0KXSPjmDQpDOKMCGYh99H2kd+9UlZtKrlQHiHRzBj?=
 =?us-ascii?Q?Tz3y78M4F+bGILrLGUb6772W1FD1L1u6mnFbd46MU6Oepyd+s5fjoPA9hTPD?=
 =?us-ascii?Q?aHIWtQ6yZmqtbnoSVKEuNppB7tqPJTuFlV+9L7SDhz5by9oLhTNo8Y8oFa3G?=
 =?us-ascii?Q?3k2m1kuIIbndrsnGg4fpgSrsAZLzXRsjWNGGp7muXUCd2P/xOfbdZ+zTn9kL?=
 =?us-ascii?Q?rSM3N6yh0F3xD77YU7D08ql8mOLBC4vRCZyfIN5htJTuY9WBe8S/p2UoDvo6?=
 =?us-ascii?Q?m3fljk5JKT4VS89/KAPFcPtuEAB3jodD?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 21:13:55.2924 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4526fb33-a40c-41ef-6fe5-08dc96ee0daa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7123
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

From: Joshua Aberback <joshua.aberback@amd.com>

[Why]
This error message is unnecessary because returning when aconnector is
uninitialized is the desired outcome during initialization. As well, there
is no equivalent error message for read_dpcd.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index f5e1f2d1c5f2..b34301e4ab9b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -575,10 +575,8 @@ bool dm_helpers_dp_write_dpcd(
 {
 	struct amdgpu_dm_connector *aconnector = link->priv;
 
-	if (!aconnector) {
-		DRM_ERROR("Failed to find connector for link!");
+	if (!aconnector)
 		return false;
-	}
 
 	return drm_dp_dpcd_write(&aconnector->dm_dp_aux.aux,
 			address, (uint8_t *)data, size) > 0;
-- 
2.34.1

