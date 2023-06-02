Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82AF8C7EE2D
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Jun 2023 18:43:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB84010E60F;
	Fri,  2 Jun 2023 18:43:34 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8C6410E607
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Jun 2023 18:43:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cq8hAKXvoYcrUL0Lk2z6cVQwADmBeANt+ZfGohqyTBctbnSErhOppMlE96ng8qiyprPURmUCFrh61a0m+p8hsD7AevlkbbUCKQK2usGObE71REpgQ+MVbI/CVzWRMpP9PN6ytnRErwd7m9z1dJ6knRfc0RVXuQkqK7oU+DCSsaASKVF3Yiak1Fp5Gbd0jH0E9gvh/e9YwZC3J1Bpjr30dg66VnXsgSG4rNBzSPz0DyX704UtolQghFyuvPpIhKadiUgN/JHl8NB/DmUwaNDiaSs5BIzw5vsiMRPJ+Gx6ZeLh9R9BaV3Xp+JZf8kr0nHGxlGmln4ZGAF/vd2h9O+Fpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=57SRGQCvkzWpJDI67jOVGX8XJTA87MBhkttsqC9xrrk=;
 b=COh5c1Jjwj9bP4ixGLz7wb0A09/eBIOG1IYrEKiK8y2sNcz7j/tyqe0LAhlvFBpHtP4CegtCw7PDEdktbg2/8dLsrOD766N+htafklVDyaxTtjXH3q3aXDa1frY3ZkpUh4PQ+RkUcV8t/qSFYJWlTpeG40x37+Ili5IlqzEYH4S2ZV23kUi/SEXVhwzFb58xQwJvKidEXv8dJSd6x4zNipkyZwI2Or0lBMrJ2Q4JnPPLQXiXJcXD6LyQzafnevE4duMTV/3mQ2SPPHR3XxsPfCBDK2GRDE/nWnt1numW5txQjrK+qSuCyKvejDWTwvznfSAsKcwY/nVZDoDNkhPt+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=57SRGQCvkzWpJDI67jOVGX8XJTA87MBhkttsqC9xrrk=;
 b=tJ7xvSN5MmF0LjGRVFEmLVhUMzlFfJxM4NDB1npx1sTU0MrkvGVL9BuZ1D2kSwvpAVGaujNkkPfy1PpO+DLZViRtFbp+9Rf+3shhiKW6F9Un+FyiwpKs762u7nQsKL/w1BtiYyxNzTZw8bmYVZ2do2+Gp0kFnzecjdSYsY5OpnA=
Received: from MW4PR04CA0148.namprd04.prod.outlook.com (2603:10b6:303:84::33)
 by DM4PR12MB5358.namprd12.prod.outlook.com (2603:10b6:5:39c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Fri, 2 Jun
 2023 18:43:28 +0000
Received: from CO1NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::a7) by MW4PR04CA0148.outlook.office365.com
 (2603:10b6:303:84::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.26 via Frontend
 Transport; Fri, 2 Jun 2023 18:43:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT114.mail.protection.outlook.com (10.13.174.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.28 via Frontend Transport; Fri, 2 Jun 2023 18:43:27 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 2 Jun
 2023 13:43:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] Revert "drm/amdgpu: Differentiate between Raven2 and
 Raven/Picasso according to revision id"
Date: Fri, 2 Jun 2023 14:43:11 -0400
Message-ID: <20230602184312.752618-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230602184312.752618-1-alexander.deucher@amd.com>
References: <20230602184312.752618-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT114:EE_|DM4PR12MB5358:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bcb335b-5e84-4104-095c-08db63994159
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bnWwOHMPkzaI4P5Iat4W+51/PMXQnLSob+H3uLzy18fSPDJ45BaSaDQdcvM7KAGBlCHFXti0PgnprunsldKFfWtGWOxUHZdv0+oYvsjOQv2YZe1MIWftHAU8MEA0SKqgU8RmqAz5JqN2tDKNi/W5+ilu91mZYsalbjv21Ke482ZJIyT8m5Y9YoQB7f/NdACYBU77JOU1tjrDIx/ht6tihW3FrpFU3jNet6Bv7CDEgz3Jko5FYTocBnkTVwiBol97+wzHfpdrO5FWPrK8x73VpJtHGHsWmuvbt2GMub905THho8RxHGvY8Nlr+j92cqO4OhWCdnic/uBQvy1EkK1d/Qwqu5NJS1w4AnT2v7PddhpTXVC68OYitHocOOLh5kY8i+/l17nqF+++xVIpHxXhAc+PJ5TCf8MCf7BSHH2r/jpQwPJCeYTH2/szE1jc4jp/vrT4YP6R7qDpAwwbTrhZ61R0jly2imGIYeBCWlh3YTOBIXI2brg7+pvWE4mQQ+YJ4h/rofgiNRYSpBN8SfdpXNDJ0UQXSK6+Qp1x5ix4EvuSvQlLy3bCa4DsUpFUiBumiCuo6CIWBdg5PmZKTojopnTFogRxR77uSnz4e1EHbZU3D729/xhzmxIsdLzO/s6KoJ+x7kXc7KbMSC+Q7GWQqMY9yXZF4XEB9BPMvYVfZaizitqK4VysGoQ4ugj64A0JAaXaM9dLuvduyKGMHj+w8+tLXo0mesMl3EFdHXInSfQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(426003)(16526019)(47076005)(83380400001)(186003)(2616005)(36860700001)(6916009)(6666004)(4326008)(7696005)(478600001)(316002)(70206006)(70586007)(54906003)(2906002)(26005)(5660300002)(1076003)(8676002)(966005)(41300700001)(8936002)(336012)(40480700001)(356005)(81166007)(36756003)(82310400005)(86362001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 18:43:27.9151 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bcb335b-5e84-4104-095c-08db63994159
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5358
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jesse.Zhang@amd.com,
 michel@daenzer.net
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 9d2d1827af295fd6971786672c41c4dba3657154.

This results in inconsistent timing reported via asynchronous
GPU queries.

Link: https://lists.freedesktop.org/archives/amd-gfx/2023-May/093731.html
Cc: Jesse.Zhang@amd.com
Cc: michel@daenzer.net
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 33 +++++++++++++++------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index f092a1dbdb56..3bc0b100936b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4023,25 +4023,30 @@ static uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *adev)
 		clock = clock_lo | (clock_hi << 32ULL);
 		break;
 	case IP_VERSION(9, 1, 0):
-	case IP_VERSION(9, 2, 2):
 		preempt_disable();
-		if (adev->rev_id >= 0x8) {
-			clock_hi = RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN_TSC_COUNT_UPPER_Raven2);
-			clock_lo = RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN_TSC_COUNT_LOWER_Raven2);
-			hi_check = RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN_TSC_COUNT_UPPER_Raven2);
-		} else {
-			clock_hi = RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN_TSC_COUNT_UPPER_Raven);
+		clock_hi = RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN_TSC_COUNT_UPPER_Raven);
+		clock_lo = RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN_TSC_COUNT_LOWER_Raven);
+		hi_check = RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN_TSC_COUNT_UPPER_Raven);
+		/* The PWR TSC clock frequency is 100MHz, which sets 32-bit carry over
+		 * roughly every 42 seconds.
+		 */
+		if (hi_check != clock_hi) {
 			clock_lo = RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN_TSC_COUNT_LOWER_Raven);
-			hi_check = RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN_TSC_COUNT_UPPER_Raven);
+			clock_hi = hi_check;
 		}
+		preempt_enable();
+		clock = clock_lo | (clock_hi << 32ULL);
+		break;
+	case IP_VERSION(9, 2, 2):
+		preempt_disable();
+		clock_hi = RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN_TSC_COUNT_UPPER_Raven2);
+		clock_lo = RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN_TSC_COUNT_LOWER_Raven2);
+		hi_check = RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN_TSC_COUNT_UPPER_Raven2);
 		/* The PWR TSC clock frequency is 100MHz, which sets 32-bit carry over
-		* roughly every 42 seconds.
-		*/
+		 * roughly every 42 seconds.
+		 */
 		if (hi_check != clock_hi) {
-			if (adev->rev_id >= 0x8)
-				clock_lo = RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN_TSC_COUNT_LOWER_Raven2);
-			else
-				clock_lo = RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN_TSC_COUNT_LOWER_Raven);
+			clock_lo = RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN_TSC_COUNT_LOWER_Raven2);
 			clock_hi = hi_check;
 		}
 		preempt_enable();
-- 
2.40.1

