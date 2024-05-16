Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B24AFC25B7C
	for <amd-gfx@archiver.kernel.org>; Thu, 16 May 2024 19:27:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7A3410EDCA;
	Thu, 16 May 2024 19:27:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qE5p9/7H";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F223F10EDC5
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 May 2024 19:27:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQpVTanZruMnIdeb6duy2+vKlTPjjZodT8/8fLpO0/DAGfvZf2N9OCvSNQyP6LAXLFpi/sZ78D7eGPfC71fRMZSigtAJ+Kkdq+MGaCxB4OgpQ6FvQrBCYSPeYTVp6Qv8W6ym1D1tNld/yHNkVRSJi875vj8qGw1Amdz8V5+P4x+9qTSydh1g+cHA9Y1KCETRdM9o1930L87EEfKgP3KN21QqUl8/ZVtI42LKMn34ZzPlL7Up37ya5LJwOrZNGRXXuMjHSZREPwrrcVFVsCkwGzf2iNbDgQ8uPe4eEwbQOD9Ts7aTmhNEE+ehCmfxe8Inxv2atoTqly5lWRLV8Y0nSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4yeItSYYTQLGBB5rWHhgrlzDxcfdkK50CoJwSZEwac=;
 b=nj/KzqUPN7QzxDFtJ1BskxcRcOWHg1p0jSSZ0+d2QULJswfbPl3DTQDKAotO9aGLofwLhX60X+0OCyCUOWhaDFU2Cixg7XeWybgZKjrXLONA4/dx7dMLxtx4mAoAy/yWWezwO3QxiLCK+ebV18/WHmIq4A8sX6HfMeUQAso33GFNz0C5Oo6HlHQIy6Ing70hgWZuP8XZfqCAJh3cxbOCgt82LS1NGQhw4xgssRg4ntQajsa+4D8ptGgR5CqHnlveBCNo9lKVHjKs9GSSiivhq221Fu/xqZLh+g4ZkjOjcwQdgf4SKXW9miqod99PxONTz+q4QhK03AMaz+hd4dwhnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4yeItSYYTQLGBB5rWHhgrlzDxcfdkK50CoJwSZEwac=;
 b=qE5p9/7HDABLsugR4KIMhtGOi0HZ5Jk8srvfIvHUWlcQWPiw8Ls9Lk5beGsif1mHtQsIXvw9DAk/IWKK0Ue8xVew27RWXRCFDSWO/0Pu6z098rYflYY+RQSKPPXlfTzu7KCkcXWeo14kWQ7cKtFKeIHyqasm199xXbE5w83tEGo=
Received: from BN9PR03CA0424.namprd03.prod.outlook.com (2603:10b6:408:113::9)
 by DS0PR12MB7656.namprd12.prod.outlook.com (2603:10b6:8:11f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.26; Thu, 16 May
 2024 19:27:16 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:408:113:cafe::8e) by BN9PR03CA0424.outlook.office365.com
 (2603:10b6:408:113::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27 via Frontend
 Transport; Thu, 16 May 2024 19:27:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Thu, 16 May 2024 19:27:16 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 14:27:15 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 16 May 2024 14:27:15 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Aric Cyr <aric.cyr@amd.com>
Subject: [PATCH 24/24] drm/amd/display: 3.2.286
Date: Thu, 16 May 2024 15:26:47 -0400
Message-ID: <20240516192647.1522729-25-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240516192647.1522729-1-Roman.Li@amd.com>
References: <20240516192647.1522729-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|DS0PR12MB7656:EE_
X-MS-Office365-Filtering-Correlation-Id: 28b3a3fa-ef4c-482b-b8cf-08dc75de31f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UzcGnwRYnX6UU3N3CJmHzmEzcuBVituCbV9PB1N5kM2vGTStsmr5OXd466Ey?=
 =?us-ascii?Q?N8avMNkBWSGv9inPuGHSK0VAZEQ9R1pqrv/jXWEia3JHl5DSlngRO+Z/aeyF?=
 =?us-ascii?Q?85ibkYh7xtg58psQmbh7mzFLMefE3/0yCoAW167IjVd6tIOpxRGuVQZ+RQm1?=
 =?us-ascii?Q?8+AP9Nt5HpJgTrQIVDrNrIe6lDzVI6efpLYVkquCN/tYnpW8Nh8+jk88DNC2?=
 =?us-ascii?Q?cw16ZSenTtsayC7K1Y536QU9SWPPIQWZo63fMQE6Rd4yiy4qkbf35n1SXxyE?=
 =?us-ascii?Q?5tEf+/Gae+g957vRpwXTvNgOYh3rMU8VeQfB+jYrKWuu+Mn6ost4OjcSanpA?=
 =?us-ascii?Q?WAv/+qYkVuAJOxB0p4jN+b8iF6vKcASw3/mBjZk5ERfwZ9DEhNKzxhyf+09a?=
 =?us-ascii?Q?hLLV/kb/MC9NAyNFc78n9cE1Vv4n06o5UPaPByk6BAHDBbEkO/1+A3MwWA4C?=
 =?us-ascii?Q?951HX8CL3kf2qlGVCUxxQ3HjhF7blb6JTyN0VnwPk6H9XzrPzOz3BjWC0IXw?=
 =?us-ascii?Q?gL27JwLRYrYMDKMLIQ3o0HbmgBezynLFO2zDk2Cyl0qKtPRpHAmiWZ7XpROr?=
 =?us-ascii?Q?cgdCAqqeC51xsnMiLlwcenWMCGZbC7AW/P/WNCrb8Y53nx9wmn7NyshPkYTu?=
 =?us-ascii?Q?bdf5h+b1XSXbtVY7BUBA2NxyGmPJI0CB5bHh/E0MjutLp4mFARIcSlkIrUAI?=
 =?us-ascii?Q?ltoXcwyHD/cByQH5/+whnb7mndZkJLxOaeYsmxiZca690G7smE+ilR1lhnuY?=
 =?us-ascii?Q?U2rCP/j5ndPH7fcZs1E+t1uapmSVV/Y5MWS2fNgGUb6shrwI2uSUF8pUxJv3?=
 =?us-ascii?Q?M9hPaVmvL0fkHBwuzbOubGnmX+3KoomuQu5FT1o+TbJzilwE5SIule6pfWT/?=
 =?us-ascii?Q?5v4b3zFJ+vgV/v02/4xqXqakPcjTZ1UtiH1SnUf/RMssLArKWFQWUI9sy12h?=
 =?us-ascii?Q?AGg/S/8C3F5mbZ3LUQZ2MqoUL9ELJanQNf/NOnbjJhpHkic5PeDMUmgp6Tb1?=
 =?us-ascii?Q?yOlpaoFoTB5A9dCtqM1/NqlXUTW9UDA9zpVaZ8objnZjTu110EQ38UPLWgCE?=
 =?us-ascii?Q?jybmJRpHqDw8691gNmp6BITWiUgrNSXuY+nsIcGg+QQJ/Wc+4HdFufGLX5m5?=
 =?us-ascii?Q?C/OL7gw89IVccfGShpYGRneIPjnp9d/yiKRxWAdf5FMAmhxHg3mTb4utvKdX?=
 =?us-ascii?Q?YOPvdTA1IVHwkalAG7QoSjTfZvwi8TV8MXYU513OPwYGLGrJ3QRVMZczcOae?=
 =?us-ascii?Q?NJXFxFnfKwbp8mUih8ROBVnR50aAjEHW+L6wyhinmhrho/t1ZUSdusNNPIw5?=
 =?us-ascii?Q?BJCKZ91ZVMJ/HnKyAIEwKniZ8Bn6nhnhCeNW6EOoowuUq39aCqKrVB9Hjbzc?=
 =?us-ascii?Q?+1pyIKs44ecDR4W8o3D+NtK5qkGf?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 19:27:16.0937 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28b3a3fa-ef4c-482b-b8cf-08dc75de31f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7656
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

This version pairs with DMUB FW Release 0.0.218.0 for dcn314/315/316, dcn35/351, dcn401
and brings along the following:

- Fix powerpc compilation
- Fix TBT+TypeC Daisy-chain lightup
- Fix ODM combine setup
- Fix OTC underflow on dcn35
- Fix DVI config for dcn401
- Add ips status info to debugfs
- Add 3DLUT DMA load trigger
- Modify clock programming to support DPM
- Disable dcn401 idle optimizations

Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 5ae74558632b..a711e3fd6f1b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -55,7 +55,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.285"
+#define DC_VER "3.2.286"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.34.1

