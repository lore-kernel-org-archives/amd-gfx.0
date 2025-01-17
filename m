Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D31FC02185
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2025 19:19:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0923410EB72;
	Fri, 17 Jan 2025 19:19:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Gt0wVMNP";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE62510EB70
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2025 19:19:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UIkUJ1f7IOEL0VMHPt8ZmLbTyHdsRmpGGuBwNR9gMPSyc7pp98IA47BxlcFsj0Zz++1gpXoaAf3o0JwyffNPN9ngjX1lt70RHhGr65sou/rPyjvC7DiNVzaEVXKED2IQ8sHNoda67P3gaixgrE9XUbUNs68FjZDgJtqC6SqGCHogYALOJFoYmgRqZ2BTF7D1WAFpD6ffh0RFlLBw0rSAeVTjdPTB0Yv1xDub9+zUQct3+hAA7MezWnGhjAh/y9jAgEsqE6wAgwXmmCIen6jnyQqgoBBDd0YyUajhlTvTM2PiqIbsMshjKnuer9qp6fYTsPEG6Cnx40U8d0o7BgVosQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IkX66C3uw5jsbAPZbsLCwj2fRLsbjYTbs9oHQ/VTqes=;
 b=pgVg+ijJ7U90t1TMSvuxxcUMxPhAkivb+nVCEm3+juJfjPI9X51CSwkAf+4z86KmxedHoy5GqlHpn5Y+lRfTb6MF2hEqikdg9v8ibXay0uLqhH0BVCh9o3qIIdQ1nMOna/vc6+nCicMlgX4IPSHS6OzZUxqvQEsHamDn/0ywsc6Fnq9STQsSCBq8fhgCLoW9Cilt6u2IEl08xSTOy2U1YEJMJtYih+50KDBiqIuKYQM46auqi8gJ8Qa3TyoxlywKGzpCPK+uXjlXpOHX/lpS/aagx0jlQO8TL6BMdu8KPV6zCcCMu0A9qSkZBjFO5f9Z24JjYOCXton/dYzfkuPOIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IkX66C3uw5jsbAPZbsLCwj2fRLsbjYTbs9oHQ/VTqes=;
 b=Gt0wVMNPlo4Z9s+2d+GuDGhi6KD5tqhFcq2K8C6z85/b8ERwDJVOeiety1H6QpFnxJP6agcECctr4lYbYS0oMxaY7OeWrkCawXIKCWzQ985W1E5kmrk7gBXiXznvPFWMiTTmTAiDy42x/gvegAthKlV3/7wExViI6NOPCoNzWAU=
Received: from DS7P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:223::18) by
 BL4PR12MB9478.namprd12.prod.outlook.com (2603:10b6:208:58e::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.16; Fri, 17 Jan 2025 19:19:11 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:8:223:cafe::d3) by DS7P220CA0026.outlook.office365.com
 (2603:10b6:8:223::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.16 via Frontend Transport; Fri,
 17 Jan 2025 19:19:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Fri, 17 Jan 2025 19:19:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 17 Jan
 2025 13:19:10 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Stephen Rothwell
 <sfr@canb.auug.org.au>, Aurabindo Pillai <aurabindo.pillai@amd.com>
Subject: [PATCH] drm/amd/display: fix SUBVP DC_DEBUG_MASK documentation
Date: Fri, 17 Jan 2025 14:18:56 -0500
Message-ID: <20250117191856.2781254-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|BL4PR12MB9478:EE_
X-MS-Office365-Filtering-Correlation-Id: e599b59c-f57a-4fbc-7765-08dd372bd2a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jsUFUwG4P83bM5TWfFXq67u3Pz7BkwuAU+amUuvRn6bxnkGagZJLwiXcMSJN?=
 =?us-ascii?Q?QR1ZVVpvDvqnuIfD6u/+mS0UNFVnTLU/WFWUFybfbhL3MivRSxU/2MptPa2k?=
 =?us-ascii?Q?zpUre4xwBtxM+iUoUXwubeEVhJHknlqIn6HoKk7F7xu/FRHOCPZDjpoAv0BN?=
 =?us-ascii?Q?nECPDj/id5QDn1TAV1+ZPURXHMADpBW79MtRUFsFfAdotIVYQ7VYcxShMNON?=
 =?us-ascii?Q?DNVAwIAMBS+qABsfITJBXrkVj5bz/b9bTk0ltK1OzTiTcK0kxuPOia68RfF3?=
 =?us-ascii?Q?yiZuLXWmcnHMBSrHuNgGPKlnU2etUZKM7VNd+PJ+NhwQG77iuIUkJxW/BO4h?=
 =?us-ascii?Q?UenoFY4l1rHh1nnl/HQvCaTTVLWmC/pG+K/hAi1jxM9C1St+c7Hp73MVDmnF?=
 =?us-ascii?Q?dV7DOS0K1MNP6Nfd5RqQzCmO2hPZaUy7DL+dAz2/VhTqQ2NrvJDpUvljHx0H?=
 =?us-ascii?Q?zn988AJ0V+erj6s4r9TCzACXP3EoZYYbIf7EqpxOgH/HDCm+gBBTfC3gmXge?=
 =?us-ascii?Q?mq7hRodBVcJ0JZTjz3IyF9aBlF2mVQi4Zg+Hgs8C6KXQdilQh1UlC+P+qXTg?=
 =?us-ascii?Q?MbpYRiACZ7bs/7+GrKyJbz5K6CoUEawc5yPg0mkRwsHzMCogUk4g4xR/t53l?=
 =?us-ascii?Q?dy7RilSmCsUdOGMYH1q/pNptN8xlcZmhWSlBPG9kl2SMYk5U+mfVxuwx848y?=
 =?us-ascii?Q?AInsZvyuy4fvhqeTxJiHivW+i5NbzfttNVAq/7YZcKRNqGQ+Nd2Vepl5VU4M?=
 =?us-ascii?Q?oD1lzeA9awqgQ6Hg4jlfYu9bYYTVskhRV96aPWAvaYMXBSHfK0zeNHZUmDNV?=
 =?us-ascii?Q?ZZwXCyQuqyUtciZbjWWDkp5GZMnEXnbpuLTnDgkOuVJt21rqC6/+OpnzntSt?=
 =?us-ascii?Q?KG1lwvRPCc4Df1wbcu6oR7oDZ4I/hWFD2md3oa4Xs6COC1qwhS9wv95/63Na?=
 =?us-ascii?Q?QGRPlpn3rbWjMhmdXbmtyWtnPp1k2kkllc1zS+RHXUYOSjp/e3Eosm9aCeb+?=
 =?us-ascii?Q?7BskYR9E0RxPwzHPq6+zx32dWLHRWT1ntGPFsyVI6vWtegfs3lK2wvxbiSIm?=
 =?us-ascii?Q?v+Y2ngsipz04FdGx/khFW0/qCnvFvioJ5dhh5Nge82yp0F2MDQs/Q4W8c0wl?=
 =?us-ascii?Q?I9/ms2H1mq9CYOSEzGfQ8m8iQH3cQRfapkRLft45jZraJe4vORPPfdJiuLkx?=
 =?us-ascii?Q?tGk120qeJtaURTliO3y3cVZQTEQhVo0wMLepGy58bD7SyNT8K3Gf00eHaBSP?=
 =?us-ascii?Q?agsTkCNIc+Bj8DbiMzZ6HKqsVcx/Z1jN0wC3cxJx2KN1jdWgrXi3DBphVb/J?=
 =?us-ascii?Q?pktB3372yLAoMFi9mk2KymXarnlgErP+DOVTnKuhA8mpXIy3AxiPe67azwVw?=
 =?us-ascii?Q?2/j3rO879wFENnn2jYEc5MzcnH2QpXc9qdF0JphMiEhD2kPPbLpQ52nBOJLP?=
 =?us-ascii?Q?nh5Px5Xi83kAa4DqF8KJHi4VRNvmHzWuFcs55mTLolqpQmM0oPB0KbC5K7EL?=
 =?us-ascii?Q?PyCZ6LIDxzbWjQM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 19:19:11.2121 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e599b59c-f57a-4fbc-7765-08dd372bd2a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9478
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

This needs to be kerneldoc formatted.

Fixes: 5349658fa4a1 ("drm/amd: Add debug option to disable subvp")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/include/amd_shared.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 5cb97414e4a33..6dccee403a3d1 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -350,7 +350,7 @@ enum DC_DEBUG_MASK {
 	 */
 	DC_DISABLE_HDMI_CEC = 0x10000,
 
-	/*
+	/**
 	 * @DC_DISABLE_SUBVP: If set, disable DCN Sub-Viewport feature in amdgpu driver.
 	 */
 	DC_DISABLE_SUBVP = 0x20000,
-- 
2.48.0

