Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F9E6C61D85
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Nov 2023 08:57:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B933210E6EC;
	Thu, 23 Nov 2023 08:57:54 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::61d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5A8210E6EB
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Nov 2023 08:57:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aDMFF058mPzl8drBgM1qRRCIGZFpKH5+1O1beCGZF6m3beReyJF9l0RKr59bdJpBIRcYRoAJSlSIlXjRvchRKZ/r8mRLt+eG7AVhU1nKpQmsRnydY1s6QLnwk9R317S0Sd7JxV+J8EkuAYjTkpwS3IEX/ynolXCSk4bOxA9ffGzWUqjyeD1DKmU3O04CyxDUS3f/xbpeFZ3QojmWnr+rfNrCComczyrDQLIvUdr+V+h/PL4S3OhwR3H/uV/isGtdn5YQXgqCCUZ2SSZ399ZvvwVTzkUYG3q4M6ieCq9SMjaa5vu2nHOg/ZpiPpVZ2bwC/1rijzTIK5BSz/HlpERzXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/E87SbCU7idTsTzES6oO7WSB8Z8t58ocmrOU+yeYLAk=;
 b=I/zksj3vDtyHX0N4HbNH7ENccg0W+lPbKFnXaRbDiRa8ZNDWTW9QE/x0tgrFDaDhVRoqSWBagXnGDhPiP1rqH5KkwCuaBHZXCAWYk4AizhaUQRGFukjDYy18kPuAAqzUcfLX4NZjbAlpACqckZqU8xvsI/Sh9dGXMaclvPSflBVrZiceIBbQb2MwqP0cYuZkGAnZhuJVGN4UefSxkJwkhrfPPSr7rZCwayqA08ggUni03LRnn/S9I1QP4MBl3Vyb6QsQ3lhHOQZefy80n2O/n32ZMw6klq/FEmsoNvVjD4uGrfP7iaBYwHABYvCD0kxQ+uUV27yqWuOrljB/jE8TEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/E87SbCU7idTsTzES6oO7WSB8Z8t58ocmrOU+yeYLAk=;
 b=L5GEuQU8LBYKE9sScnkGwUf6yKQJOsGIwplaTKOIIjt9srZKJp/R040141tva92BLTQpKk4X+4D+pKdts/GYK2Fua7Hf+bBuvFCFT0rzh+4acclkmC5/DSp1x1JrkqAik06HUb5+PE7PqHhtB6aV+Jdj4ZRfhvFNpbuXCtD+ygo=
Received: from PH8PR20CA0014.namprd20.prod.outlook.com (2603:10b6:510:23c::24)
 by SA1PR12MB7176.namprd12.prod.outlook.com (2603:10b6:806:2bd::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Thu, 23 Nov
 2023 08:57:51 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:510:23c:cafe::4b) by PH8PR20CA0014.outlook.office365.com
 (2603:10b6:510:23c::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19 via Frontend
 Transport; Thu, 23 Nov 2023 08:57:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Thu, 23 Nov 2023 08:57:50 +0000
Received: from amdoffice.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 23 Nov
 2023 02:57:46 -0600
From: ZhenGuo Yin <zhenguo.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Skip access gfx11 golden registers under SRIOV
Date: Thu, 23 Nov 2023 16:57:14 +0800
Message-ID: <20231123085714.254103-1-zhenguo.yin@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|SA1PR12MB7176:EE_
X-MS-Office365-Filtering-Correlation-Id: a779b95c-4a60-4fd4-7af3-08dbec02459c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cl1s+HdBDeYW+WoBr18SWSZhlgjhITfhUqRwY7j9ySSydqX7D3NMFNtcq838SoEJpE+ZrwR1vE1NHwawCih5D7plcl44j7/luGzMHLPq5Wm9vz1mhrsufVA2Y/RuM7y2c9IzwR2Vn5X6hb3zVQmotIhoDFNFTxDNXUnVis9tC0dwyFogTV/K+ZEZJHPczjYVWbTAmBT+dMrhkp7MgYM8s1TLTBA6sMVTKPx2fOiyxjWnlnLpUQAa6q+yb7xE2rHyq6cB4cphrU/iMCR5DJRJxnncfiyDTd4fd5Eci89EHHFklcmFkSzBJfGAuqQ69LxmGRe2xT4eidP0cuKRO4NcbihjvmDcd4xx5d0wp8kHWt9IIfq621jxZzT5G0HLD2zS4OHZxeDBH/f4/9XIj56H9K6m4znG/BDe5rzRkHJH0yqgpcFcNhnrZt6OTmPUp6WHAAGaDkq1SzVqpE1l9OEZ7szlYKx9fq8ZLAnBqoxBfeYUz1Hqg8DKT6aWhSfDNy2dZ00Ucn6mWB3fkpFDKkBLnSZdkg5R2DR6QBbEn+/M5tem2nVL3fC1jVTQ9V+ij0PkB/xSWuudrkdnMCoYMXF2ua/kH5SZqiYinGhFEK9RRkD8A74YOSNaLhQET9X8LPKtlLeisc9XykT9mqDMYlIItnloOSnLnU8K/mloFKYNSik2DUfxVUamZ2y31Ma88/fSd2L8YhwxNVhKl/gDce3JKgfPAihHeOkmV5M6I4P6RVSw1NTi5Vcw45JgXNmQr3p2czmMCvEpgz6K9P8yWKxS+w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(376002)(396003)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(82310400011)(36840700001)(46966006)(40470700004)(40480700001)(16526019)(7696005)(2616005)(47076005)(356005)(81166007)(478600001)(316002)(8676002)(8936002)(70586007)(70206006)(6916009)(36860700001)(26005)(426003)(6666004)(83380400001)(336012)(1076003)(82740400003)(40460700003)(86362001)(4744005)(41300700001)(4326008)(5660300002)(36756003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 08:57:50.3467 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a779b95c-4a60-4fd4-7af3-08dbec02459c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7176
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
Cc: ZhenGuo Yin <zhenguo.yin@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Golden registers are PF-only registers on gfx11.
RLCG interface will return "out-of-range" under SRIOV VF.

[How]
Skip access gfx11 golden registers under SRIOV.

Signed-off-by: ZhenGuo Yin <zhenguo.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 8ed4a6fb147a..288e926e5cd4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -293,6 +293,9 @@ static void gfx_v11_0_set_kiq_pm4_funcs(struct amdgpu_device *adev)
 
 static void gfx_v11_0_init_golden_registers(struct amdgpu_device *adev)
 {
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(11, 0, 1):
 	case IP_VERSION(11, 0, 4):
-- 
2.35.1

