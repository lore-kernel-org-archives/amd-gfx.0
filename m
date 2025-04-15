Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42C59C3DA4A
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Apr 2025 14:59:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2150510E118;
	Tue, 15 Apr 2025 14:59:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kpjFJ3ou";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09FE210E118
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Apr 2025 14:59:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iGfR942PbD7cxTpHvAlR+a+NIfOHltv7o+iZhNsR0cn6y80WA4+0C08yfWJ5E/d91SpNj1mJjlyLODvPyPX0vV2ZAiBUxhGFcQmaqcyRiCKUq/ec3/EpZET3h64lCLczYMMe5XuoX81o5ZQU5TjbpY2Ajojk+xAxnZ+oYP7yywT+0TWkR3K6+pL70kqkRxYyLvM21KF1/9JPGUmxDWdB5xBtFBfEY/XESae0w629rxwcgZk3vT1OOvRxk+M/osjVCmB81PlEGfgI8pJZD5N6gZKm6223MLBDaCEcFO1RPX94yDPQYqmfPVjI8rieu9MGYyxlPCRJGgWKBA/kF3626w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4YxTO2uEcBV+6jVXwcK+mteEHpXKQnKIsnuC/2QgsQ=;
 b=Fl+MGjLiyI+8bMTf8l5rEM7FdeAtlN5k43JhB7a3dTtMvO4ToCb+9uvKSWvHxZbbjwUMflN9qTPow98TT3AkASDkNi3CBieDmRhl2zmmHPEpujMudyGPo4dYAqEFVDuzVRLc85y63m1a5vtUOfjZo91ObuS22zGV8YnSqjOwtbOHWTTclI7fmxDOvrfAqoV0hkJvqPXGfU9vSNBYutdHxNTeCmLrBQY3SYGLaN1kQ3kmrOpZq7yZuIh+kG2So4oDuauITk3oz/TvPVn7cmPeCd2f4Lv3wItn2CY21U91WKbA6RaFFCfV97wdM6QPCE/bpbqxn3rghkLzn3XFB23Frg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4YxTO2uEcBV+6jVXwcK+mteEHpXKQnKIsnuC/2QgsQ=;
 b=kpjFJ3oub4hmT8F6i183ouhBARVNXPhJM2W3/TD37r8Uz7cbOSrS6+gmY/RzYQCqximhRKy3HD9p59+7z7ZOpWoOjA5fEzARVL3KNUs2aoJklaQtFHgf/sjCo1Mn16TP+ykUaLv+a9AR6/ZJ7qhikpWHJ9Vidwd1xGOwEwaWg2w=
Received: from SN6PR05CA0026.namprd05.prod.outlook.com (2603:10b6:805:de::39)
 by SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Tue, 15 Apr
 2025 14:59:35 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:805:de:cafe::4e) by SN6PR05CA0026.outlook.office365.com
 (2603:10b6:805:de::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12 via Frontend Transport; Tue,
 15 Apr 2025 14:59:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 14:59:34 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Apr
 2025 09:59:32 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH 03/22] drm/amd/display: Avoid divide by zero by initializing
 dummy pitch to 1
Date: Tue, 15 Apr 2025 10:58:49 -0400
Message-ID: <20250415145908.3790253-4-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250415145908.3790253-1-zaeem.mohamed@amd.com>
References: <20250415145908.3790253-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|SJ0PR12MB5673:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d4da744-6b6b-4264-fe1d-08dd7c2e22bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?q8F+E5zydHT2tDnS6PmCKorT5blPOItTaC26TiygdGRU3LGypTNLPMeM8dUB?=
 =?us-ascii?Q?4VAxdHiHQISamjg0N19vBx+KmLKOBH0FiWey7t1Kv3WbD3dvU7UA/YbgFQAm?=
 =?us-ascii?Q?QjplDTqCruq034l0HW7wjLqAz/4S5FQXqFPRIK2l1Z2G6eBCM2xphAfBF+Al?=
 =?us-ascii?Q?NdklrOUQJ4TRXCwE4yWj19QgKpllABJ1Fe5QX/OUoqxSL3hJAXW6AmnZfPdZ?=
 =?us-ascii?Q?3Wz71YNfNY2JmoVJFwOqymGCO9m12raogVVt1x4OTtF4FxzcPJgu2AS0vDtb?=
 =?us-ascii?Q?twPZPXwaLYsGwG0BCsfaTfMoZzHyihLh1i/L5Ss3EymDZT11eZolA3JguB2l?=
 =?us-ascii?Q?uIxnQeIKKFJ1d+/bKv/qh0z/tgpFhoqaKDp/P3h9pJziM3DXH8yTaACa+bV3?=
 =?us-ascii?Q?XjtQq9mqg4lFQ8NNBObtlxX6q46LzLnF0P/vuQ7pW+xgPltqfurccxaUgVze?=
 =?us-ascii?Q?13PKFn20bm8TmelK3WQ8zdxh3FqtD/E3odEKCmUymmgkYLD9r788yyh+14yY?=
 =?us-ascii?Q?+CDAFpEyGIme8YIBaX6aWVXfx5QWIaScj5IPuNoTatyL4SHaKrnf1YHa4HUe?=
 =?us-ascii?Q?4Z7UTx+GY2E8+d+yTKonkNSrLGdUL+pQOIChQH3wCKJe03ogTym7pk/BhKEU?=
 =?us-ascii?Q?CyA7MKni2PKrtWP7K2kLb4klkCY3I43o4smEUJUVo8EBG5Ih7bZhqt7u05jG?=
 =?us-ascii?Q?VQ7WrrHVQ/SFC1uROFw2TWDI23B+iBn+KFIwf1toTjUagZsvD9Imc+Y8VyVp?=
 =?us-ascii?Q?oTxdpdK+mxc6rQh/IqOiTcPoWWp2voPZ1z7TOx1aeLXZEDlT6iJv/93+RTua?=
 =?us-ascii?Q?RqViIZf7BWiOKWq30Hi1+Yf6i+39T8/D6EATq9G3VElibxdNCCOH+KIiN/HR?=
 =?us-ascii?Q?gmke70/RnkFMRhuwLy2YaYw62xtykBmCWRsRW+vm/iTQRljD92sgzJHowqZD?=
 =?us-ascii?Q?zWi15kIInARDbauRRCHg1B4O2dx3h4URpPs+r0zmqL7gUGxaPENluEEYAEX8?=
 =?us-ascii?Q?Co2vafjFBmVhFx9CVRGvnsgo8TZXkNOI/jauUQ1sURVW24u656QtuwPQ2ZT2?=
 =?us-ascii?Q?WNdOV/kGfpijmt5r0EAijmSxHCoSBLo3vMXsodlUt6ark5+6mxrtMjmmudL+?=
 =?us-ascii?Q?0hjl2hFSU9lt3AWwHTTQM64rrfIyPkndsa2OEznaF649gtgwStKNYNh6U04A?=
 =?us-ascii?Q?v6rMVELr4N8aDA2fZxJss6WKJhIjtDnGfSHWQmjWPBFoqWqO4TXjJ/sDwAkR?=
 =?us-ascii?Q?2b6NZKWcG8VlNo9RV/ZqODqC8zJ3Kbgyp3ZXmSct1TsGM9dwuVCho+ffnqNx?=
 =?us-ascii?Q?X5J2tHAii0lGzyY9QcK4o/W+X/B0YOHUdIcXEyQ1TOYq3DDwrsFRKFg/prfz?=
 =?us-ascii?Q?FvhT3Uvn2oeI8KL3WAlu4cpKunsyIRMLx3xJAifLoo22NXyTP009G7KA9V+W?=
 =?us-ascii?Q?GwZMmdM+iAWLq4ov0uqZmKc4QaBkgUHoQnIsybYbYH19look+BypkriC1yMV?=
 =?us-ascii?Q?QRphA4d2ecUadtA2NAOtlQCn9eBM1Lq2d1/Y?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 14:59:34.9070 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d4da744-6b6b-4264-fe1d-08dd7c2e22bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5673
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

From: Mario Limonciello <mario.limonciello@amd.com>

[Why]
If the dummy values in `populate_dummy_dml_surface_cfg()` aren't updated
then they can lead to a divide by zero in downstream callers like
CalculateVMAndRowBytes()

[How]
Initialize dummy value to a value to avoid divide by zero.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index 2061d43b92e1..857ce1695fd5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -896,7 +896,7 @@ static void populate_dummy_dml_surface_cfg(struct dml_surface_cfg_st *out, unsig
 	out->SurfaceWidthC[location] = in->timing.h_addressable;
 	out->SurfaceHeightC[location] = in->timing.v_addressable;
 	out->PitchY[location] = ((out->SurfaceWidthY[location] + 127) / 128) * 128;
-	out->PitchC[location] = 0;
+	out->PitchC[location] = 1;
 	out->DCCEnable[location] = false;
 	out->DCCMetaPitchY[location] = 0;
 	out->DCCMetaPitchC[location] = 0;
-- 
2.34.1

