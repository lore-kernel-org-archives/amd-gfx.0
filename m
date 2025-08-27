Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B0D9CA0EFF
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Aug 2025 19:02:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28FB710E16B;
	Wed, 27 Aug 2025 19:02:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mSLlSVVM";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C443710E16B
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Aug 2025 19:02:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N3QjQso1ZiQhnwNUQoFqASbGyeo0G8qwIq4DTTjwWelWO91kh3hE+mWt+HLIjG30fxD2zAQM7pPj/bU6NGmUl+JO8yyb61g526UY1puS+qojpe7N2yhrBWZAWMYGutTfDEWeQKoR+zcAn8iBr4BBgXgTdecnFrs4d4yngoyzNDpZn5X/fTtsAI9T7kRPEObgxYuk+kEaIQfHaRDR8FlEvAyI0I6rGwBIopGl6AWV9iC+Ya1sIHRj3XyxBQike9lkSUzxR8FByznoQDIiG9rido3wqmCd8oUYvgTNJWcOUzcWIaTgSsnvQDN47uAksnAGvd9Y3bgveCWxjTkzzJSnKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y3g7DOcRLPnjOdCqNrcqqDv7tDNWUX7mDw6zsrrqOLE=;
 b=lg72MzFA/jbAmGv51PnlC8xqJwQKoNO9MBOdzXKR4KHNUYRYVA+ERzWEUqbHvlqZZLkOuOW/FnFDxCOc9R2X2jrD9YbBkGGY4vnCNtwDgoPYA/LzIvTKQYlKyp8qsF0nnkdLH7TYxg0Ofao5fJrzbxWdXYQIKHzgqoGxov16yBtu80iWMrgGs0DxnEhnlpXPFQaSYXt082IXfrSJq/u8FUQI3sRzjwbrfYWNhO4GpSby55z1do6A9r2EaTNAFKSQN179Z9wGJlr35D6EmTVS4BlaI/XuSbygmAqxndAk2+kLZQjJKpg1UtSfD8/kyvHJ9Gfc24m2fU55s+0tJg/lMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3g7DOcRLPnjOdCqNrcqqDv7tDNWUX7mDw6zsrrqOLE=;
 b=mSLlSVVMm0nEiBrfaNN87AYAKIKNkD4dJk7l4aMYUZxjVBMw00T7l/c+XP3P8vVFX1Y4ZsZHqBQwuQlXuNzTV0VpIkLQ7ClAdD/zZALfpi6S6KDqygFsf4NWIoelTQ6Pu+FeisoULYDVccJjaHeE/tylk3YGvetz8t+aMHOGB/E=
Received: from BL0PR05CA0007.namprd05.prod.outlook.com (2603:10b6:208:91::17)
 by PH7PR12MB8594.namprd12.prod.outlook.com (2603:10b6:510:1b3::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.19; Wed, 27 Aug
 2025 19:02:49 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:208:91:cafe::a2) by BL0PR05CA0007.outlook.office365.com
 (2603:10b6:208:91::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.12 via Frontend Transport; Wed,
 27 Aug 2025 19:02:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Wed, 27 Aug 2025 19:02:48 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 27 Aug
 2025 14:02:47 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, <shaoyun.Liu@amd.com>
Subject: [PATCH] drm/amdgpu/mes11: make MES_MISC_OP_CHANGE_CONFIG failure
 non-fatal
Date: Wed, 27 Aug 2025 15:02:35 -0400
Message-ID: <20250827190235.1784506-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|PH7PR12MB8594:EE_
X-MS-Office365-Filtering-Correlation-Id: c5b6b135-178b-484d-4b4d-08dde59c509a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4V/nWp5S3UMq+DqxRaXIoQ2T+3/Wo/ZphLhdwtPMogpLb3vyKn5V33X6Y98b?=
 =?us-ascii?Q?RP7a2iPRKH9nTdTWP4jogZPR4mNlY1H/96O/U7viUMIeKY8Ic2Ws9XVgXA4H?=
 =?us-ascii?Q?hhv/I1k773FM7nMpdhAffiJO3nNjCP6f8HYeCALFW3IIMUqKXjyrK/9CrfW4?=
 =?us-ascii?Q?uREPb8i3/JEKLjM2EQOrITC173bcL8Yje1EgsITQXOAnpdVUvgkPR380V8L6?=
 =?us-ascii?Q?QBBHwPkjzPlx1Q6rZUTmzqRZitoNBzbY3ijiJVUeC7JLlFcEWIM3klHF6Q2E?=
 =?us-ascii?Q?li78Wus35yQr/Vl6uAArJOFsGMMZa2uiOVnYgIahHZZJ+P44kiQ056Ct3jXf?=
 =?us-ascii?Q?CaSCz6MtE2yi6ev8p1kcFFaCPruw/eocmzdFAKPOhzlZ9aW4wQUsBIWMAsSa?=
 =?us-ascii?Q?R6u41XAHEuWiW02cTwq5lCwzYDpsg+PdkS15d0sKVh0C7Bx9rNDeNQoMfm5G?=
 =?us-ascii?Q?OjRxHNVRaCOYNvNYBwNzDph+QMWqolBYE9/K3KjkAHnwAzw4icN5Boqnf+vg?=
 =?us-ascii?Q?cRArJbkIomPcwJfpqueMIpS+c4+EcqRC21Q8b+mHrQ1ytNo7m63UGsGGUWw5?=
 =?us-ascii?Q?+FYLXz786Buwis0zQAUpvdw2QB7CcAmQ+n4lD1briHpQ7ehp+t3J40ODprGm?=
 =?us-ascii?Q?z0HeUzRzVdqjP/BZqIbHbP2rvwLglAEt/DMf7oERzNujj/JXV7fEwF2LOgSj?=
 =?us-ascii?Q?jnFrgs7TudxlqEq1W0nzkDW/tUu4tFcN2umJiu5UzLewhAXmxGTc1gjesyIK?=
 =?us-ascii?Q?9IXtXXmBpF4S6APTpCVmQqrtGzhrmwcMLrtNkVVcnx2WrEJY8cPncBHaj2Ye?=
 =?us-ascii?Q?J4YALAIN8ADP6V4slJWl2ogVtyE1cYs9KV9GFe4oMco2yLKCGmNmoufpb6rJ?=
 =?us-ascii?Q?jAAdIoUwMiWrHhu4lgwkFnbueCOMVaa41XXFXU0JIxPL8LkiIDpD+fbTUDVF?=
 =?us-ascii?Q?IMof2mpF3chCurtFuj8ioCHJmnjWAoDlfN+JHtHTXaTsZo3vAjIqUdWBDkKE?=
 =?us-ascii?Q?TSSpwnPXyu8IW4iRhLUaunP4fia3bGsooTh7n2ruD6NFF6IJBTERkZYFygij?=
 =?us-ascii?Q?YJm0xYgHub5w3bMAXrxrybg8/UXbqSw93/I0WUmFb+WR/7bLwhud9YVX/e32?=
 =?us-ascii?Q?Uj7H3Hxgu8MTgwJel2UtL2822ZGEft8RJ8R0FYgmFM1HEsCM7iNroe0N4Bop?=
 =?us-ascii?Q?CKBbkOucr5G/c864/lAyBYTTTk7GyrwF+DMuJCk9UKHaCIAYySqhS4151EHQ?=
 =?us-ascii?Q?k/5NzAkDiwks8YQj91Mm4htmYtii737VIRUvhNLIAB6DD1xqMOuWK9O2xjNU?=
 =?us-ascii?Q?ncVicRAnfLTs3zY7t+e7tie+OSl1u7i21FHE0uLqMgrT4FpnaSQB6ckBytEk?=
 =?us-ascii?Q?TyNFfMaF+fOldBe29YoMmdBWf3weJOp+pMRziYfdTlYmaECehBvQk3tWc3hS?=
 =?us-ascii?Q?nqnwjBOS7RFj18cfskirzHP5kNMODzVAxJW6m5iMAFQJw1ftBa1nGQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 19:02:48.5995 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5b6b135-178b-484d-4b4d-08dde59c509a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8594
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

If the firmware is too old, just warn and return success.

Fixes: 27b791514789 ("drm/amdgpu/mes: keep enforce isolation up to date")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4414
Cc: shaoyun.Liu@amd.com
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 28eb846280dd4..3f6a828cad8ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -641,8 +641,9 @@ static int mes_v11_0_misc_op(struct amdgpu_mes *mes,
 		break;
 	case MES_MISC_OP_CHANGE_CONFIG:
 		if ((mes->adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) < 0x63) {
-			dev_err(mes->adev->dev, "MES FW version must be larger than 0x63 to support limit single process feature.\n");
-			return -EINVAL;
+			dev_warn_once(mes->adev->dev,
+				      "MES FW version must be larger than 0x63 to support limit single process feature.\n");
+			return 0;
 		}
 		misc_pkt.opcode = MESAPI_MISC__CHANGE_CONFIG;
 		misc_pkt.change_config.opcode =
-- 
2.51.0

