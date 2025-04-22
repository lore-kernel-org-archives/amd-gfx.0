Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC8BC369C2
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Apr 2025 16:08:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E86210E5D6;
	Tue, 22 Apr 2025 16:08:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O59CqN33";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8ABE110E5D6
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Apr 2025 16:08:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X52+aiiOu/5ZlTvz2GqfR6X5dBOY/jT9J5RRqJZFUteKtDW1WK97XocDwtQXmmidrWW6zc17A4gcOmK+ZRruDn1Gm07EHzGlDJXrJ0juQor/z3n5GLxvM0L3s4x3cFg9CseQB07jf6Spk61yn2OBrT+IeEVAwtpe9+e3gEL4+moK35IOJRIflV3tCcVkJV0F7Mbn+fJPajTr/wSa5ZcqYgi8oUtzNvdwRGm3NLgPxUpsL3QcawRiE3+poXJi18Ofz5MkDuTP8TkBZa5IG2F4c3BGjPqwtxv8ZqA8S6d+RrtwLgbwOLURziY9A/MowD+evck0J2o+7cHe7PC5EusDow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wVUZokIgB8/1Pu8R2iR5pHtZy+wJgfqb/4TznAXl9IE=;
 b=sSuk8fyFkxYXzqhZpujPQHpKogVSedjNltMZPP/4om7jY1os+fTbHm5W7lFKWolYLyZ7d+5GkH7bvFcWoP71wnBRG/uylPmTHG4QaPG4at4PyT9+HR8NPMDLPjFW9wjmXgQPGpUiFP9boy6dE/F+4FyQ3OUuSIa96gaDmE2S/V1HJekyzBTh6hYjwE6tCHGZ8FvC8JYikYX1gmLL4QFKIEWhCLvlpIA3C5joBEBMLCWHihFkRD0dSGrnmb9PBT0dkpSyh/uDnP/UwaTqsZDCC6xbHo/VDOJResmk4EaxPMWN86SYPC++iMOXokgMOcP6wyPucr5OrI5j2c7Oy4F10w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVUZokIgB8/1Pu8R2iR5pHtZy+wJgfqb/4TznAXl9IE=;
 b=O59CqN33zQivWX0fSIPe7stSqt/wlgREFNz1hk/sF8qtIaFIDd++nc4+eROz0hpYQTls5URoc4V440TZnhceoBCo38m3WbvfKo5BOLgBbeWoOpqP3+YpZQZYq5gVBlyNFIuhh5Fey1NQW50ksivp5pgXvAcBB/H5wLNeGpqCdkg=
Received: from BN9PR03CA0321.namprd03.prod.outlook.com (2603:10b6:408:112::26)
 by SA1PR12MB9471.namprd12.prod.outlook.com (2603:10b6:806:458::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Tue, 22 Apr
 2025 16:08:01 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:408:112:cafe::7d) by BN9PR03CA0321.outlook.office365.com
 (2603:10b6:408:112::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Tue,
 22 Apr 2025 16:08:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 22 Apr 2025 16:08:00 +0000
Received: from AUS-V14-AI-23.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Apr
 2025 11:08:00 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: "amd-gfx @ lists . freedesktop . org" <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] Documentation/amdgpu: Add Ryzen AI Max 300 series processor
Date: Tue, 22 Apr 2025 11:07:40 -0500
Message-ID: <20250422160740.3610-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|SA1PR12MB9471:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b1260a4-6742-487d-4996-08dd81b7daee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OgDimgYUEn2XXMO/qCKH7cwgDK/NGYflRWrlfgxykpCvuiIBLkD70BBKEZfD?=
 =?us-ascii?Q?gBRIS+LfnPEO0ws+c1i3mET9yAKWqK6TD3hi64sE6TfBqRm1nMg+3ru7pblE?=
 =?us-ascii?Q?guvmfpl1ZVaR4M2v9lZmelsLW9++mKg/qoNyO9zJj2cWACEWAdOHS72B9oqA?=
 =?us-ascii?Q?0VBHdmMD+LndlbsTHm4EwKJ6Hc9Xpkynn0kr+GC/FFzlIKHH245gCLSgN5a0?=
 =?us-ascii?Q?eIw8a+U/E4GhNFIm5wPpYc5mEpbkQ38r1SXOCEPFfFvGMOwoy9g9Qcyi50Q/?=
 =?us-ascii?Q?B8VP6KeaJ5bFVzWoi7qcP55z5n20R6a3z81brEbvm+vap37Tsn5mVsL5Ct2w?=
 =?us-ascii?Q?IsVChrJOameC2IcM2s5Es11ywOvhx0E2fqJelHy6K6Eq/cPCxBwvVlXumPIq?=
 =?us-ascii?Q?y5EM8mxgcaaBoXHhRiMu7NGgIWNiHRFYfbJOFUK59Tn7kQ4o974KXXvoJVaR?=
 =?us-ascii?Q?KJBW73Sz7ppEwzFdG9loKuod1bk+ixajcX3cOW9gM0OjC2MP14wsi84hglZ1?=
 =?us-ascii?Q?qSyO2lbECQmHi7dNHpC9ojbsJ8I36jrKgdtMFV7ExnTwhUvJ6hIaBneRLKQl?=
 =?us-ascii?Q?bJDoccOHfYYUI9lhKQL3vVH5pL+mXkArY2kISgLYHglfkMro/jQrswPh0aJR?=
 =?us-ascii?Q?//EQ9AI8x+IEs34C224qE6U0CT/IKo1JOVBFFkDz21H/tFkZ1Ri5zL+23V33?=
 =?us-ascii?Q?1p1PyJGDF0pwJuZNBidV4E30dIM/gFMv5u0Qj6ckohszuplLvUQf9PoP1JEO?=
 =?us-ascii?Q?VSwEH1knp6EdR8wbdtapilAp2s4KVscINQX9ihZj74S82Efo5+m5IGrsfS2Z?=
 =?us-ascii?Q?548LXakORWEheDeVFt3r84qg/4ohG/pj5OymK1J6jQfVVXdukwUUVRKOByDw?=
 =?us-ascii?Q?+aF3+5qRPqHD2r2bDLoeujJocW77u4HYyoK4p+kC9ppLPs47uLuZc08slG3S?=
 =?us-ascii?Q?NY4CczlIAxaovShoCRaT/doJU+92xJCTCkDecTXtDHCO1SFN4UWcwkqKaiQA?=
 =?us-ascii?Q?Eu8o3ZipxhkvWROSFQ+Ga9kSiWeHh1nBNeKIE5nbgXkyOYktNbh1HK9jp+Uk?=
 =?us-ascii?Q?6YahZy8hFFBdvvbka4doGUFBzt8WrdrbZ3+nSdvZ4DCGp1sFMb8q1tv64fbK?=
 =?us-ascii?Q?s4Kk8vbyVd6R90V/9Aq5QX6NIZUsO3Gxi12N3ic8e6QsbbLp+xG18ioI2y9Y?=
 =?us-ascii?Q?RwZBT2zh8pdek9bJh1hRT6sdOscENaJXeblhU4VHfgw34QA08nvxC9J0/MpD?=
 =?us-ascii?Q?sem+d6Dg33SgSkNRLoE3EpMsdxHuxWc0VyYCdQ6O53hS/E/kKqC6kW7PwZqL?=
 =?us-ascii?Q?DD1RlUkzQF+RTey/n5o7lhuVMW9jd0iGfOo+ZR4v7m3Wg32laQDCuRbj/KLU?=
 =?us-ascii?Q?u5JAHG73jIi85RoS48Zf5x4sVuYz6z+Heo07dvJ6P6iifDJSO65JmoJ/idhL?=
 =?us-ascii?Q?q2cORHt5wph/xrfo8fA/gGCzVsLIxmxPWFg4CMZCD9/KTmElNFRFz8BrB6te?=
 =?us-ascii?Q?AEJRKt+lzdyQ2RVAlyPhqMu/sZXM8OUze1ZKitOZMBEHSq74NvngYMhD/g?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 16:08:00.8057 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b1260a4-6742-487d-4996-08dd81b7daee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9471
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

This has been announced so add to the table.

Link: https://www.amd.com/en/products/processors/laptop/ryzen/ai-300-series/amd-ryzen-ai-max-plus-395.html
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 Documentation/gpu/amdgpu/apu-asic-info-table.csv | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/gpu/amdgpu/apu-asic-info-table.csv b/Documentation/gpu/amdgpu/apu-asic-info-table.csv
index 094e76a65dc0..1d50b539677f 100644
--- a/Documentation/gpu/amdgpu/apu-asic-info-table.csv
+++ b/Documentation/gpu/amdgpu/apu-asic-info-table.csv
@@ -14,3 +14,4 @@ Ryzen 7x40 series, Phoenix, 3.1.4, 11.0.1 / 11.0.4, 4.0.2, 6.0.1, 13.0.4 / 13.0.
 Ryzen 8x40 series, Hawk Point, 3.1.4, 11.0.1 / 11.0.4, 4.0.2, 6.0.1, 13.0.4 / 13.0.11
 Ryzen AI 300 series, Strix Point, 3.5.0, 11.5.0, 4.0.5, 6.1.0, 14.0.0
 Ryzen AI 350 series, Krackan Point, 3.5.0, 11.5.2, 4.0.5, 6.1.2, 14.0.4
+Ryzen AI Max 300 series, Strix Halo, 3.5.1, 11.5.1, 4.0.6, 6.1.1, 14.0.1
-- 
2.49.0

