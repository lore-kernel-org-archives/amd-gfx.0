Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25CA3C19F4F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 May 2024 17:19:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9766E113121;
	Wed,  8 May 2024 17:19:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4b2HkBMv";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2064.outbound.protection.outlook.com [40.107.102.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 548B6113121
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 May 2024 17:19:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cGV4HttLjADa9vn3c3thqCeYkwQzxlA0bYyDh5HHGZLk0bKtWbzeEOpw1XTVC4NN2Sj4VDNo8g4yTwbRarAAApOP8yXKvZUH3zph8r1YGNWVmL9V88A7e+HNc2uUa4FqiwhBxwnCRoiVw82YjwzikZtzunF+Dg3oQhqdYj52XeLE2N5odHaW7GAET/1tQp6irsRqjhXGY190uLkWXMBPpE8+jDpf+dKc/uJi3RJW/3lfPmZ52iIjAyz+39RkxZE/tqRrFJ4qK7TMgheEcBeOkBnnVK/rlqrUUpHGKJfei9Gp3xlMMetgXeslTNXUBKP9tYxMbUqJMNV5Ewkn7Oa1IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M7/ltDCyRR3dktIkpho0G7Yba/j8p+bbyQ17zKy1Jbg=;
 b=VyBIz551mEDw5MakfrL+1ZX+O/V9tdRdSmjqPA/WlEBTVRvpSyeu9PMtd1mogg4ny+o0Sb9qJ1iQNB3OP7eb2Bizg4EJnjZiJt4OLFqM3lXymWBR9ehgsj/xUF/CSLdPbw+ZY/WMHcmWsx1h2fzULm9+SMWd0auvcJzmUXALKV5wPWXQy9HLy4OVKfuyyH4MWkC98cvu0C9O+Wi0gdrmjbmy0phTcXfJkydZalbLHBivfflNiGEnRVaDL4o2tvvMMXJg50krxVmZ013WqN7DaymAOh/br9HpRp3+niCr2aqmf/0poUBba6c+poM78Cxvf/EGpFl8dyQXG1OmXNRoLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7/ltDCyRR3dktIkpho0G7Yba/j8p+bbyQ17zKy1Jbg=;
 b=4b2HkBMvlNUURe19PIELJR7GnVi4ZWoRKDgRak/taWbbCKHjj53rxhxon6UEyCuQ/gL1jQOkH5STVr6uGByKc/HL4oFusAtR3UvOaw29wlyHVOu3stQjlT/g9CX/1PHgwNCYUggibUPOEZd373Zl/2BbjbhECcYk5UdWC4+Yeks=
Received: from BL0PR03CA0015.namprd03.prod.outlook.com (2603:10b6:208:2d::28)
 by IA1PR12MB6113.namprd12.prod.outlook.com (2603:10b6:208:3eb::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Wed, 8 May
 2024 17:19:34 +0000
Received: from BN3PEPF0000B372.namprd21.prod.outlook.com
 (2603:10b6:208:2d:cafe::b7) by BL0PR03CA0015.outlook.office365.com
 (2603:10b6:208:2d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45 via Frontend
 Transport; Wed, 8 May 2024 17:19:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B372.mail.protection.outlook.com (10.167.243.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.0 via Frontend Transport; Wed, 8 May 2024 17:19:34 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 8 May
 2024 12:19:30 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Aric Cyr <aric.cyr@amd.com>,
 "Alex Hung" <alex.hung@amd.com>
Subject: [PATCH 20/20] drm/amd/display: 3.2.285
Date: Wed, 8 May 2024 11:13:20 -0600
Message-ID: <20240508171320.3292065-21-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508171320.3292065-1-alex.hung@amd.com>
References: <20240508171320.3292065-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B372:EE_|IA1PR12MB6113:EE_
X-MS-Office365-Filtering-Correlation-Id: e2018208-529f-4a57-86d5-08dc6f8307d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|82310400017|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fR+tqsEIMg+/5Nx4qyOAqUhQkitXpG9vn5pTmbbWuHFw9Uz+C1demJGq5YaR?=
 =?us-ascii?Q?HoVYThOE5HoWPwomIeSGFUb6f3MpwHZSmIkDZvekgH7sM1qxuvGku8nPeO1Y?=
 =?us-ascii?Q?yUHAV6+nvk8kR0LRq/+JWDOaRzNca8omupf4jRvosbDafbvYUbnS7Zin7Bd/?=
 =?us-ascii?Q?e1k5PmdWrQSQBUOG0MzlE31k5ZL4TbVG5FqTVIDS11gl2XG7BONGzOZp7o9V?=
 =?us-ascii?Q?Ysg5rcM7J7OAZ4j9N1/xe/3zB7zbReMCNrAmcFzvNiYbIy8DXQqI14UQh/VP?=
 =?us-ascii?Q?fRDsszTAAYbAHberHmmU943qKTSEL3+US2iq/BUVgdxA5WzBJP29Le/lvTeU?=
 =?us-ascii?Q?AZMjvvdejP+rKZyqgs3+jQ9jdZDKCVEqknO+9zhfxAhSNorxnMNAJLoRJjr2?=
 =?us-ascii?Q?zCfWZZ/Bg2Kz1TR+8nFV/Vnv154WEsgMsnKpqmy1cAc7xFAgFxdCsea2j4n+?=
 =?us-ascii?Q?xvJcjIGSysAh58sIBnfYRp1H9YCogih5DL8W0GRvDLFBrLJrdBJ9RolVPOQP?=
 =?us-ascii?Q?SCOoxkbmtlX6RJy8mfkH+9+cnWzQbfUQzOTslh9BhKAntbFHCq86Wu7IILwv?=
 =?us-ascii?Q?RWbZTebB84lKFCDNgUby337RLvSHYbUiSVpAx5iBlNWFRJmsGqS34Za9kyNh?=
 =?us-ascii?Q?eULKguH6R7vj4+FSJaLoPHuMujJxHjh7ZU7QzonU7OD00TJ0kWrD+wMvRKtD?=
 =?us-ascii?Q?Ri80fVoCeqGjlZseyHLqdj8qJGCZPTsWUbTr+KXqr4L7oEAD76O6nhV216iP?=
 =?us-ascii?Q?P7W/JNuFiEzDb9a/9xzk8hpFXXmliTsnDbXKRegHTBJgrLO0Cju0If8d03AZ?=
 =?us-ascii?Q?JZDsIRvjx8k3AOWhhbrBs8xVLmFYaa9huabSiNNw2BRCBg6O6zqml0JPNM0E?=
 =?us-ascii?Q?Y6jf94ikDW6juso2L2JKeRapdprNlir2O0RorVIE4tzg/T/tnjAHfjXMT3k9?=
 =?us-ascii?Q?EjKwK3gY+WjiTcEr/kJ9P5c3yG6nnsXLNhKyjixO5cIsIT7xk4+vzS1CEYuP?=
 =?us-ascii?Q?N8PfcM+wTXdrqnotBSkKMeRTedhzM5kDamxlq6vSVhHB/8pDa3zsi8i4k+bs?=
 =?us-ascii?Q?RvIQ87dOaBUkSk7j726yrtd1/Q6tCA+wJ8doUEym+DlgkGBHBwHr7hGDgXMr?=
 =?us-ascii?Q?+95KZzK1m7Vj0uuMDn4oJVUuZptlCnHOMsaa/CSHRHaIxeQDSXAUl7S8R3Pa?=
 =?us-ascii?Q?k8ZL9zn7K5qOvrX6+Puq0GVwZjtODsYLtHtbE4m3IOfaeXOjnG+Sjhkv+jBd?=
 =?us-ascii?Q?lOcJvEVQbuPvphJ1U6/k2ieZz12TQzyzP/Jk+TI2TpU/HTlgRZy1lR5DR11b?=
 =?us-ascii?Q?QOf4d0wXhD/erPR8z6WgAeAVsFt2G42Ks5Bs2ab0VPDr1QCaxwdiBolns2Sv?=
 =?us-ascii?Q?2tcM18CvbA1Rs5q8QBDoPE2vXz2c?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400017)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 17:19:34.2157 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2018208-529f-4a57-86d5-08dc6f8307d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B372.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6113
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

This version brings along following fixes:
- Read default boot options
- Find max flickerless instant vtotal delta
- Refactor dcn401_update_clocks
- Reduce I2C speed to 95kHz in DCN401
- Allow higher DSC slice support for small timings on dcn401
- Don't offload flip if not only address update
- Check UHBR13.5 cap when determining max link cap
- Enable SYMCLK gating in DCCG
- Expand to higher link rates
- Add left edge pixel for YCbCr422/420 + ODM pipe split
- Add resource interfaces for get ODM slice rect
- Add COEF filter types for DCN401
- Refactor DCN401 DCCG into component directory
- Fix 3dlut size for Fastloading on DCN401
- Fix write to non-existent reg on DCN401
- Remove USBC check for DCN32
- Remove unused code for some dc files
- Disable AC/DC codepath when unnecessary
- Create dcn401_clk_mgr struct

Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index d550b6f97039..a7ba80c84128 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -55,7 +55,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.284"
+#define DC_VER "3.2.285"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.34.1

